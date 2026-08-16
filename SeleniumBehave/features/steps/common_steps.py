from behave import given, when, then
from pages.PageFactory import PageFactory


@given('user accesses "{page_name}" page')
def go_to_page(context, page_name):
    context.current_page = PageFactory.get_object(page_name)
    context.current_page.open()
    assert context.current_page.confirm_page_is_opened()

@when('user clicks the "{clickable}"')
def button_click(context, clickable):
    context.current_page.element_click(clickable, 1)

@then('user is on "{page_name}" page')
def verify_page(context, page_name):
    context.current_page = PageFactory.get_object(page_name)
    assert context.current_page.confirm_page_is_opened()

@then(u'user should see the error "{error}"')
def error_check(context, error):
    returned_error = context.current_page.get_error()
    assert error in returned_error, f"'{error}' in '{returned_error}'"

@then(u'element "{element}" should be invisible')
def element_is_invisible(context, element):
    is_invisible = context.current_page.check_element_is_invisible(element, 2)
    assert is_invisible, f"'{element}' NOT invisible."