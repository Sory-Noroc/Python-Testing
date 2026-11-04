import logging
import json
from dataclasses import asdict

from libraries.api.UserDTO import UserDTO
from libraries.api.base_client import BaseClient


class UserService:
    """
        Service stored in the behave context, responsible for calling the UAC api to prepare the database state.
        Reads mock users from json file and saved them to a local list.
        Functionalities include user registration, login, etc.
    """
    logger = logging.getLogger(__name__)
    register_endpoint = "/uac/v1/auth/register"

    def __init__(self, base_url: str):
        self.client = BaseClient(base_url)
        self.users = self.read_users()

    def read_users(self):
        with open("./data/test_users.json") as file:
            users = json.load(file)
        return users

    def get_user_by_username(self, username: str) -> UserDTO:
        self.logger.info("function get_user_by_username called with username {}".format(username))

        user_data = next((u for u in self.users if u["username"] == username), None)
        if not user_data:
            raise ValueError("Provided username not found in ./data/test_users.json")

        user = UserDTO(
            firstName=  user_data["firstName"],
            lastName=   user_data["lastName"],
            email=      user_data["email"],
            username=   user_data["username"],
            password=   user_data["password"]
        )
        return user

    def register_user(self, user: UserDTO):
        self.logger.info("function register_user called with user {}".format(user))
        user_dict = asdict(user)
        return self.client.post(self.register_endpoint, json = user_dict)

    def login_user(self, user):
        self.logger.info("function login_user called with user {}".format(user))
        raise NotImplementedError("login_user() not implemented!")
