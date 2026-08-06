from behave import when, then, use_step_matcher

from core.utils.RandomFactory import RandomFactory

use_step_matcher("re")

@when(r'user enters username "(?P<username>.*?)" and password "(?P<password>.*?)"')
def enter_login_details(context, username:str, password: str):
    context.current_page.text_field_input("username_field", username, 1)
    context.current_page.text_field_input("password_field", password, 1)

@when(u'user enters random username and password')
def enter_random_login_details(context):
    context.current_page.text_field_input("username_field", RandomFactory.get_random_email(), timeout=1)
    context.current_page.text_field_input("password_field", RandomFactory.get_random_password(4), timeout=1)