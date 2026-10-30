from behave import given, when, then

from libraries.PageFactory import PageFactory


@given('user is on the "{page_name}" page')
def i_am_on_register_page(context, page_name):
    expected_page = PageFactory.get_page(page_name)
    context.current_page = expected_page
    expected_page.open_page()
    assert expected_page.is_loaded()

@then('verify user is on the "{page_name}" page')
def verify_page(context, page_name):
    expected_page = PageFactory.get_page(page_name)
    context.current_page = expected_page
    assert expected_page.is_fully_rendered(), f"Different page shown; page '{page_name}' is not fully rendered yet; or there are broken locators."

@then(u'user should see the error "{error}"')
def error_check(context, error):
    context.current_page.check_error(error)

@then(u'element "{element}" should be invisible')
def element_is_invisible(context, element):
    is_invisible = context.current_page.is_invisible(element, 2)
    assert is_invisible, f"'{element}' NOT invisible."
