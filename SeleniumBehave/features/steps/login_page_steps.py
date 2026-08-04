from behave import when, then

from pages.AccountPage import AccountPage
from pages.LoginPage import LoginPage


@when("user enters username {username} and password {password}")
def enter_login_details(context, username, password):
    context.current_page.text_field_input("username_field", username, 1)
    context.current_page.text_field_input("password_field", password, 1)
