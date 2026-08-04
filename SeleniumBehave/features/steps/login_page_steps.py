from behave import when, then

from pages.AccountPage import AccountPage
from pages.LoginPage import LoginPage


@when("user enters login details")
def enter_login_details(context):
    context.current_page.text_field_input("username_field", "sorinnoroc1@gmail.com", 1)
    context.current_page.text_field_input("password_field", "sorin.noroc", 1)

