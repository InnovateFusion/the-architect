from fastapi import FastAPI
from core.config.database_config import create_database
from app.presentation.user import router as user_router
from app.presentation.auth import router as auth_router

import uvicorn

create_database()
app = FastAPI()

app.include_router(user_router, prefix="/api/v1")
app.include_router(auth_router, prefix="/api/v1")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)