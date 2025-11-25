from fastapi import FastAPI
from app.api import routes

app = FastAPI(title="long text summarizer")
app.include_router(routes)

