import base64
import io
import json
import os

import cloudinary
import openai
import replicate
import requests
from cloudinary.uploader import upload
from core.errors.exceptions import ServerException
from PIL import Image

CAPI_KEY = os.getenv("CLD_API_KEY")
CAPI_SECRET = os.getenv("CLD_API_SECRET")
CGET_IMAGE_KEY = os.getenv("GET_IMAGE_KEY")
openai.api_key = os.getenv("OPENAI_API_KEY")
asticaAPI_key = os.getenv("ASTICA_API_KEY")
CGET_3D_KEY = os.getenv("GET_3D_KEY")
cloudinary.config(
    cloud_name="dtghsmx0s", api_key=CAPI_KEY, api_secret=CAPI_SECRET)


class AiGeneration:

    def __init__(self, request, upload) -> None:
        self.request = request
        self.upload = upload

    async def get_image(self, url, headers, data):
        headers['Authorization'] = 'Bearer ' + CGET_IMAGE_KEY
        response = requests.post(url, headers=headers, json=data)
        print(response.status_code, "THIS IS THE RESPONSE")
        if response.status_code != 200:
            print(response.json())
            raise ServerException('Error getting image 1')
        imageText = response.json()['image']

        if imageText is None or imageText == '' or imageText == 'null':
            raise ServerException('Error getting image 2')

        image = base64.b64decode(imageText)
        upload_result = upload(image)
        if not upload_result:
            raise ServerException('Error uploading image 3')
        return upload_result['url']

    async def create_from_text(self, data):
        response = openai.Image.create(
            prompt=data['prompt'],
            size="1024x1024",
            n=1
        )
        image_url = response["data"][0]["url"]
        image_data = requests.get(image_url).content
        upload_result = upload(image_data)
        if upload_result is None:
            raise ServerException('Error uploading image')
        return upload_result["url"]

    async def create_from_image(self, data):
        decoded_image_data = base64.b64decode(data['image'])
        image = Image.open(io.BytesIO(decoded_image_data))
        resized_image = image.resize((512, 512))
        with io.BytesIO() as output_image:
            resized_image.save(output_image, format="PNG")
            output_image.seek(0)
            resized_image_data = output_image.read()
            
        mask_image_data = base64.b64decode(data['mask'])
        mask_image = Image.open(io.BytesIO(mask_image_data))
        resized_mask_image = mask_image.resize((512, 512))
        with io.BytesIO() as output_mask_image:
            resized_mask_image.save(output_mask_image, format="PNG")
            output_mask_image.seek(0)
            resized_mask_image_data = output_mask_image.read()
            
        response = openai.Image.create_edit(
        image=io.BytesIO(resized_image_data).read(),
        mask=io.BytesIO(resized_mask_image_data).read(),
        prompt=data['prompt'],
        n=1,
        size="512x512"
        )
        image_url = response['data'][0]['url']
        image_data = requests.get(image_url).content
        upload_result = upload(image_data)
        if upload_result is None:
            raise ServerException('Error uploading image')
        return upload_result["url"]

    async def image_variant(self, data):
        decoded_image_data = base64.b64decode(data['image'])
        image = Image.open(io.BytesIO(decoded_image_data))
        resized_image = image.resize((512, 512))
        with io.BytesIO() as output_image:
            resized_image.save(output_image, format="PNG")
            output_image.seek(0)
            resized_image_data = output_image.read()
        response = openai.Image.create_variation(
            image=io.BytesIO(resized_image_data).read(),
            n=1,
            size="512x512"
        )
        image_url = response['data'][0]['url']
        image_data = requests.get(image_url).content
        upload_result = upload(image_data)
        if upload_result is None:
            raise ServerException('Error uploading image')
        return upload_result["url"]

    async def upload_image(self, stringImage):
        image_data = base64.b64decode(stringImage)
        image = io.BytesIO(image_data).read()
        upload_result = upload(image)
        if upload_result is None:
            raise ServerException('Error uploading image')
        return upload_result["url"]

    async def chatbot(self, data):
        messages = [
            {"role": "system", "content": "You're a kind helpful assistant, only respond with knowledge you know for sure, don't hallucinate information."},
            {"role": "user", "content": data['prompt']},
        ]
        try:
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=messages
            )
            return response.choices[0].message['content']
        except Exception as pr:
            raise ServerException('Error getting chatbot response')

    async def analysis(self, data):
        print(data)
        asticaAPI_payload = {
            'tkn': asticaAPI_key,
            'modelVersion': '2.1_full',
            'visionParams': 'gpt,describe',
            "gpt_prompt": data['prompt'],
            "gpt_length": '100',
            'input': data['image']
        }
        print(asticaAPI_payload)
        response = requests.post(
            'https://vision.astica.ai/describe',
            data=json.dumps(asticaAPI_payload),
            headers={'Content-Type': 'application/json', },
            timeout=60)
        print(response.status_code, response.json())
        response = response.json()
        if 'status' in response:
            if response['status'] == 'error':
                return ServerException('Error getting analysis')
            elif response['status'] == 'success':
                if "caption_GPTS" in response and 'caption' in response:
                    return {
                        'detail': response['caption_GPTS'],
                        'title': response['caption']['text']
                    }
        raise ServerException('Error getting analysis')

    async def image_to_threeD(self, data):
        output = replicate.run(
            "cjwbw/shap-e:5957069d5c509126a73c7cb68abcddbb985aeefa4d318e7c63ec1352ce6da68c",
            input={
                "prompt": data['prompt'],
                "batch_size": 1,
                "render_mode": "nerf",
                "render_size": 256,
                "guidance_scale": 15,
                "image": data['image']
            }
        )
        if output:
            image_data = requests.get(output[0]).content
            upload_result = upload(image_data)
            if upload_result is None:
                raise ServerException('Error uploading image')
            return upload_result["url"]
        raise ServerException('Error uploading image')

    async def text_to_threeD(self, data):
        output = replicate.run(
            "cjwbw/shap-e:5957069d5c509126a73c7cb68abcddbb985aeefa4d318e7c63ec1352ce6da68c",
            input={
                "prompt": data['prompt'],
                "batch_size": 1,
                "render_mode": "nerf",
                "render_size": 256,
                "guidance_scale": 15
            }
        )
        if output:
            image_data = requests.get(output[0]).content
            upload_result = upload(image_data)
            if upload_result is None:
                raise ServerException('Error uploading image')
            return upload_result["url"]
        raise ServerException('Error uploading image')
