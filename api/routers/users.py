from __future__ import annotations

import datetime
from http import HTTPStatus
from typing import Iterable, Union

import edgedb
from fastapi import APIRouter, HTTPException, Query
# from pydantic import BaseModel
import api.generated_async_edgeql as db_queries
from api.models.user import UserModel

router = APIRouter()
db_client = edgedb.create_async_client()
# UserResult = db_queries.GetUserByUsernameResult


@router.get("/users")
async def get_users(username: str = Query(None, max_length=50)):
    if username:
        # Query all user objects here
        user = await db_queries.get_user_by_username(db_client, username=username)
        if not user:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail={"error": f"Username '{username}' does not exist."},
            )
        return user
    else:
        # Query user objects filtered by username here
        users = await db_queries.get_users(db_client)
        return users

@router.post("/users", status_code=HTTPStatus.CREATED)
async def post_user(user: UserModel):

    try:
        created_user = await db_queries.create_user(
            db_client,
            first_name=user.first_name,
            last_name=user.last_name,
            username=user.username,
            password=user.password,
            role_id=user.role_id
        )
    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={"error": f"Username '{user.username}' already exists."},
        )
    return created_user

@router.put("/users")
async def put_user(user: UserModel, username: str):
    try:
        updated_user = await db_queries.update_user(
            db_client,
            first_name=user.first_name,
            last_name=user.last_name,
            role_id=user.role_id,
            current_name=username
        )
    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={"error": f"Username '{user.name}' already exists."},
        )

    if not updated_user:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail={"error": f"User '{username}' was not found."},
        )
    return updated_user


@router.delete("/users")
async def delete_user(username: str):
    try:
        deleted_user = await db_queries.delete_user(
            db_client,
            username=username,
        )
    except edgedb.errors.ConstraintViolationError:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail={"error": "User attached to an event. Cannot delete."},
        )

    if not deleted_user:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail={"error": f"User '{username}' was not found."},
        )
    return deleted_user