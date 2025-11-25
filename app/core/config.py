import os

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    CHUNK_SIZE: int = 800
    SUMMARIZATION_STRATEGY: str = "local" # local | api
    OPENAI_API_KEY: str = ""

    class Config:
        env_file = ".env"
        case_sensitive = False 

settings = Settings()
