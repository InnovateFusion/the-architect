import os

import uvicorn
from app.presentation.auth import router as auth_router
from app.presentation.chat import router as chat_router
from app.presentation.free import router as free_router
from app.presentation.message import router as message_router
from app.presentation.post import router as post_router
from app.presentation.sketches import router as sketch_router
from app.presentation.team import router as team_router
from app.presentation.user import router as user_router
from core.config.database_config import create_database
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

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
app.include_router(team_router, prefix="/api/v1", tags=['team'])
app.include_router(message_router, prefix="/api/v1", tags=['message'])
app.include_router(free_router, prefix="/api/v1", tags=['free'])
app.include_router(sketch_router, prefix="/api/v1", tags=['sketch'])

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=os.getenv("PORT", 8000))
