from behave import given, then

from libraries.api.user_service import UserService
from libraries.utils.PageFactory import PageFactory


@given('user is on the "{page_name}" page')
def i_am_on_register_page(context, page_name):
    expected_page = PageFactory.get_page(page_name)
    context.current_page = expected_page
    expected_page.open_page()
    assert expected_page.is_loaded()

@given('user "{username}" is already registered')
def add_user_to_database(context, username):
    user_service: UserService = context.user_service
    user = user_service.get_user_by_username(username)
    response = user_service.register_user(user)
    # 201 - Created, 400 - User already exists
    assert response.status_code in [201, 400], f"Status code is actually {response.status_code}"

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
    is_invisible = context.current_page.is_invisible(element, 2)
    assert is_invisible, f"'{element}' NOT invisible."
