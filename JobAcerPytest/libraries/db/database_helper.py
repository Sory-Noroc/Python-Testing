import psycopg
import os
import logging


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

    def delete_user(self, value, column='email') -> int:
        """
        Deletes a user from the database, based on the column specified, which is the email by default.
        :param value: The user data for finding the right user to delete.
        :param column: The column in the database by which we delete the user.
        :return: The number of rows deleted.
        """
        connection = None
        rows_deleted = 0

        try:
            connection = psycopg.connect(**self.connection_params)
            cursor = connection.cursor()

            if column == 'email':
                delete_query = "DELETE FROM uac.users WHERE email = %s;"
            elif column == 'username':
                delete_query = "DELETE FROM uac.users WHERE username = %s;"
            else:
                raise ValueError(f"Invalid column provided on attempt to delete user from db. Expected: email | username. Got: {column}")

            cursor.execute(delete_query, (value,))
            connection.commit()

            rows_deleted = cursor.rowcount
            self.logger.info(f"Deleted user {value}, {rows_deleted} rows.")
            return rows_deleted
        except (Exception, psycopg.Error) as error:
            self.logger.error(f"Error while connecting or deleting: {error}")
            if connection:
                connection.rollback()
            return rows_deleted
        finally:
            if connection:
                connection.close()

if __name__ == "__main__":
    db = DatabaseHelper()
    db.delete_user("sorinnoroc1@gmail.com", column="email")