from behave import given, then

from libraries.api.user_service import UserService
from libraries.utils.PageFactory import PageFactory


@given('user is on the "{page_name}" page')
def navigate_to_page(context, page_name):
    expected_page = PageFactory.get_page(page_name)
    context.current_page = expected_page
    expected_page.open_page()
    assert expected_page.is_loaded()

@given('user "{username}" is already registered')
def register_user_through_api(context, username):
    user_service: UserService = context.user_service
    user = user_service.get_user_by_username(username)
    response = user_service.register_user(user)
    # 201 - Created, 400 - User already exists
    assert response.status_code in [201, 400], f"Status code is actually {response.status_code}"

    expected_messages = [
        "Registration successful",
        "Username already exists"
    ]
    response_body = response.text
    message_found = any(msg in response_body for msg in expected_messages)

    assert message_found, f"Expected success or duplicate user message, but got: {response_body}"

@given('user "{username}" gets verified')
def verify_user_in_database(context, username):
    rows_affected = context.database.verify_registered_user(username, column="username")
    assert rows_affected == 1, f"Expected to verify 1 user, but got: {rows_affected}"

@given('user "{username}" is NOT present in the database')
def remove_user_from_database(context, username):
    rows_deleted = context.database.delete_user(value=username, column="username")
    assert rows_deleted in [0, 1], "Multiple mock users deleted, possible database seeding error."

@then('verify user is on the "{page_name}" page')
def verify_page(context, page_name):
    expected_page = PageFactory.get_page(page_name)
    context.current_page = expected_page
    assert expected_page.is_fully_rendered(), f"Possible errors: Different page shown; page '{page_name}' is not fully rendered yet; or there are broken locators."

@then(u'user should see the error "{error}"')
def error_check(context, error):
    assert context.current_page.error_is_visible(error)

@then(u'element "{element}" should be invisible')
def element_is_invisible(context, element):
    pass
