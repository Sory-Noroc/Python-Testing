from functools import wraps

import psycopg
import os
import logging


def with_connection(func):
    """
        Decorator to handle database connections, transactions, and cleanup safely.
        It extracts 'self' from the wrapped method to access class properties.
    """
    @wraps(func)
    def wrapper(self, *args, **kwargs):
        connection = None
        try:
            connection = psycopg.connect(**self.connection_params)
            response = func(self, connection, *args, **kwargs)

            connection.commit()
            return response

        except (Exception, psycopg.Error) as error:
            self.logger.error(f"Error while connecting or deleting: {error}")

            if connection:
                connection.rollback()
            raise  # Re-raise so behave marks the step as FAILED

        finally:
            if connection:
                connection.close()

    return wrapper


class DatabaseHelper:

    logger = logging.getLogger(__name__)

    def __init__(self):
        self.connection_params = {
            "host": "localhost",
            "dbname": "postgres",
            "user": os.getenv("DB_ADMIN_USERNAME"),
            "password": os.getenv("DB_ADMIN_PASSWORD"),
            "port": 5432
        }

    @with_connection
    def delete_user(self, connection, value, column='email') -> int:
        """
        Deletes a user from the database, based on the column specified, which is the email by default.
        :param connection: Database initiated connection in the decorator function
        :param value: The user data for finding the right user to delete.
        :param column: The column in the database by which we delete the user.
        :return: The number of rows deleted.
        """
        cursor = connection.cursor()

        if column == 'email':
            delete_query = "DELETE FROM uac.users WHERE email = %s;"
        elif column == 'username':
            delete_query = "DELETE FROM uac.users WHERE username = %s;"
        else:
            raise ValueError(f"Invalid column provided on attempt to delete user from db. Expected: email | username. Got: {column}")

        cursor.execute(delete_query, (value,))

        rows_deleted = cursor.rowcount
        self.logger.info(f"Deleted user {value}, {rows_deleted} rows.")
        return rows_deleted

    @with_connection
    def verify_registered_user(self, connection, value: str, column='email') -> int:
        """
        Mark user as verified so that the login process works.
        :param connection: Database opened connection in the decorator function.
        :param value: Username or email of the user to get verified.
        :param column: The column in the database by which we verify the user.
        :return: None
        """

        cursor = connection.cursor()

        if column == 'email':
            update_query = \
                ("UPDATE uac.users "
                 "SET is_verified = TRUE, is_enabled = TRUE "
                 "WHERE email = %s;")
        elif column == 'username':
            update_query = \
                ("UPDATE uac.users "
                 "SET is_verified = TRUE, is_enabled = TRUE "
                 "WHERE username = %s;")
        else:
            raise ValueError(
                f"Invalid column provided on attempt to verify user from db. Expected: email | username. Got: {column}")

        cursor.execute(update_query, (value,))

        rows_affected = cursor.rowcount
        self.logger.info(f"Updated user {value}, affected {rows_affected} rows.")
        return rows_affected


if __name__ == "__main__":
    db = DatabaseHelper()
    db.delete_user("sorinnoroc1@gmail.com", column="email")