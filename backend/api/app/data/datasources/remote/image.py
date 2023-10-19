import os
import cloudinary
import requests
from cloudinary.uploader import upload
import base64
from core.errors.exceptions import ServerException

CAPI_KEY=os.getenv("CLD_API_KEY")
CAPI_SECRET=os.getenv("CLD_API_SECRET")
CGET_IMAGE_KEY = os.getenv("GET_IMAGE_KEY")


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
        



