from fastapi import FastAPI
from core.config.database_config import create_database
from app.presentation.user import router as user_router
from app.presentation.auth import router as auth_router
from app.presentation.post import router as post_router
from app.presentation.chat import router as chat_router
from app.presentation.message import router as message_router
from fastapi.middleware.cors import CORSMiddleware

import uvicorn

create_database()
app = FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],    
    allow_headers=["*"],    
)

app.include_router(user_router, prefix="/api/v1", tags=['user'])
app.include_router(auth_router, prefix="/api/v1", tags=['auth'])
app.include_router(post_router, prefix="/api/v1", tags=['post'])
app.include_router(chat_router, prefix="/api/v1", tags=['chat'])
app.include_router(message_router, prefix="/api/v1", tags=['message'])

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
