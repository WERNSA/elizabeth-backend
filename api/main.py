# app/main.py
from __future__ import annotations

from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from .routers import users

elizabeth_api = FastAPI()

# Set all CORS enabled origins.
elizabeth_api.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


elizabeth_api.include_router(users.router)