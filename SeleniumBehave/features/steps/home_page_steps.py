from behave import given, when, then
from selenium.webdriver.remote.webelement import WebElement

from pages.AccountPage import AccountPage
from pages.HomePage import HomePage
from pages.LoginPage import LoginPage


@given("the user is on the home page '{url}'")
def navigate_to_login_page(context, url):
    context.driver.get(url)
    assert context.page.find_element_is_visible(HomePage.ACCOUNT_LOGO_LOCATOR, 1)

@when('user clicks account logo')
def account_logo_click(context):
    account_logo = context.page.find_element_and_is_clickable(HomePage.ACCOUNT_LOGO_LOCATOR, 1)
    account_logo.click()
    assert context.page.find_element_is_visible(HomePage.LOGIN_BUTTON_LOCATOR, 1)

@when('user enters Login page')
def login_button_click(context):
    login_dropdown = context.page.find_element_and_is_clickable(HomePage.LOGIN_BUTTON_LOCATOR, 1)
    login_dropdown.click()
    assert context.page.find_element_is_visible(LoginPage.USERNAME_FIELD_LOCATOR, 1)

@when("user enters login details")
def enter_login_details(context):
    username_field = context.page.find_element_is_visible(LoginPage.USERNAME_FIELD_LOCATOR, 1)
    password_field = context.page.find_element_is_visible(LoginPage.PASSWORD_FIELD_LOCATOR, 1)
    context.page.enter_text(LoginPage.USERNAME_FIELD_LOCATOR, context.username, 1)
    context.page.enter_text(LoginPage.PASSWORD_FIELD_LOCATOR, context.password, 1)
    assert username_field.get_attribute('value') == context.username

@when("user clicks the Login button")
def user_login_click(context):
    login_button = context.page.find_element_is_visible(LoginPage.LOGIN_BUTTON_LOCATOR, 1)
    login_button.click()
    assert context.page.find_element_is_visible(AccountPage.ACCOUNT_HEADING_LOCATOR, 1)

@then("user should login successfully")
def verify_user_logged_in(context):
    assert context.page.find_element_is_visible(AccountPage.ACCOUNT_HEADING_LOCATOR, 1)

