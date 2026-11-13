from behave import *

from libraries.pages.HomePage import HomePage
from libraries.pages.LoginPage import LoginPage


@when(u'user enters "{username}" and "{password}" into login fields')
def user_logs_in(context, username, password):
    page: LoginPage = context.current_page
    page.populate_inputs(username, password)


@when(u'user clicks "Sign In" button')
def user_clicks_sign_in(context):
    page: LoginPage = context.current_page
    page.click_submit()


@then(u'user "{username}" is logged in')
def user_is_logged_in(context, username):
    home_page: HomePage = context.current_page
    logged_user = home_page.get_logged_username()
    assert logged_user == username, f"Expected user {username} logged in, but got {logged_user}"


@then(u'admin button is visible')
def admin_is_visible(context):
    home_page: HomePage = context.current_page
    assert home_page.is_admin_button_visible(), f"Admin button is not visible! Probably wrong page is opened(check screenshot)."


@then(u'admin button is not visible')
def admin_is_not_visible(context):
    home_page: HomePage = context.current_page
    assert not home_page.is_admin_button_visible(), f"Admin button is visible! Admin account used for tests or broken permissions detected!"
