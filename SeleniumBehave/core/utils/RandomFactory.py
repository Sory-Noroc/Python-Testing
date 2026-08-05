from faker import Faker

fake = Faker()


class RandomFactory:
    @staticmethod
    def get_random_firstname():
        return fake.first_name()

    @staticmethod
    def get_random_lastname():
        return fake.last_name()

    @staticmethod
    def get_random_email():
        return fake.email()

    @staticmethod
    def get_random_phone_number():
        return fake.phone_number()

    @staticmethod
    def get_random_password(length: int, special_chars: bool = True, digits: bool = True):
        return fake.password(length=length, special_chars=special_chars, digits=digits)