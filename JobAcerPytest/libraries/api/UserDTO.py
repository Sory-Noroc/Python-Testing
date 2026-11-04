from dataclasses import dataclass


@dataclass
class UserDTO:
    firstName: str
    lastName: str
    email: str
    username: str
    password: str