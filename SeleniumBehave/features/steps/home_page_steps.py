from behave import given, when

from pages.HomePage import HomePage
from pages.LoginPage import LoginPage


@given("the user is on the home page '{url}'")
def go_to_page(context, url):
    context.driver.get(url)
    assert context.page.find_element_is_visible(HomePage.ACCOUNT_LOGO_LOCATOR, 1)

@when('user clicks account logo')
def account_logo_click(context):
    account_logo = context.page.find_element_and_is_clickable(HomePage.ACCOUNT_LOGO_LOCATOR, 1)
    account_logo.click()
    assert context.page.find_element_is_visible(HomePage.LOGIN_BUTTON_LOCATOR, 1)

@when('user enters Login page')
def login_dropdown_click(context):
    login_dropdown = context.page.find_element_and_is_clickable(HomePage.LOGIN_BUTTON_LOCATOR, 1)
    login_dropdown.click()
    assert context.page.find_element_is_visible(LoginPage.USERNAME_FIELD_LOCATOR, 1)
