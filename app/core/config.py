import os
from pydantic import BaseSettings

class Settings(BaseSettings):
    CHUNK_SIZE: int = 800
    SUMMARIZATION_STRATEGY: str = "local"  # local | api
    OPENAI_API_KEY: str = ""

    class Config:
        env_file = ".env"

settings = Settings()