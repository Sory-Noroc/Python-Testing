from behave import given, when, then
from selenium.webdriver.remote.webelement import WebElement

from pages.InventoryPage import InventoryPage
from pages.LoginPage import LoginPage

@given("the user is on the login page '{url}'")
def navigate_to_login_page(context, url):
    context.driver.get(url)
    assert context.page.find_element_is_visible(LoginPage.locators["login_button"], 1)

@when("user enters login details")
def enter_login_details(context):
    for row in context.table:
        locator = LoginPage.locators[row['field']]
        input_value = row['value']
        element: WebElement = context.page.enter_text(locator, input_value, 1)
        assert element.get_attribute('value') == input_value

@when("user clicks the Login button")
def user_login_click(context):
    login_button = context.page.find_element_is_visible(LoginPage.locators["login_button"], 1)
    login_button.click()

@then("user should login successfully")
def test_user_logged_in(context):
    products_element = context.page.find_element_is_visible(InventoryPage.locators["products_label"], 1)
    assert products_element.is_displayed()

@then("user should not login successfully")
def test_user_not_logged_in(context):
    products_element = context.page.find_element_is_not_visible(InventoryPage.locators["products_label"], 2)
    assert products_element is None
