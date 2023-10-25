import os
import cloudinary
import openai
import requests
import io
from cloudinary.uploader import upload
import base64
from PIL import Image
from core.errors.exceptions import ServerException

CAPI_KEY=os.getenv("CLD_API_KEY")
CAPI_SECRET=os.getenv("CLD_API_SECRET")
CGET_IMAGE_KEY = os.getenv("GET_IMAGE_KEY")
openai.api_key = os.getenv("OPENAI_API_KEY")


cloudinary.config( 
    cloud_name = "dtghsmx0s", api_key = CAPI_KEY, api_secret = CAPI_SECRET)

class ImageGeneration:
    
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
        response = await openai.Image.create(
            prompt=data['prompt'],
            max_tokens=64,
            size="1024x1024"
        )
        image_url = response['data'][0]
        image_data = requests.get(image_url).content
        upload_result = upload(image_data)
        if upload_result is None:
            return None
        return upload_result["url"]
    
    async def create_from_image(self, data):
        mask_data = base64.b64decode(data['mask'])
        image_data = base64.b64decode(data['image'])

        maskImage = Image.open(io.BytesIO(mask_data))
        image = Image.open(io.BytesIO(image_data))

        response = openai.Image.create_edit(
            image=image,
            mask=maskImage,
            prompt=data['prompt'],
            n=1,
            size="1024x1024"
        )
        image_url = response['data'][0]['url']
        image_data = requests.get(image_url).content
        upload_result = upload(image_data)
        if upload_result is None:
            return None
        return upload_result["url"]


    async def image_variant(self, data):
        image_data = base64.b64decode(data['image'])
        image = Image.open(io.BytesIO(image_data))
        response = openai.Image.create_variation(
            image=image,
            n=1,
            size="1024x1024"
        )
        image_url = response['data'][0]['url']
        image_data = requests.get(image_url).content
        upload_result = upload(image_data)
        if upload_result is None:
            return None
        return upload_result["url"]

    async def upload_image(self, stringImage):
        image_data = base64.b64decode(stringImage)
        image  = Image.open(io.BytesIO(image_data))
        upload_result = upload(image)
        if upload_result is None:
            return None
        return upload_result["url"]
    
    
    
    
    