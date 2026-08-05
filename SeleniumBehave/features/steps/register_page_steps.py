from behave import *


@when(u'user enters "{firstname}", "{lastname}", "{email}", "{telephone}", "{password}", "{confirmed_pass}", {news:d}, {privacy:d}')
def register_user(context, firstname, lastname, email, telephone, password, confirmed_pass, news: int, privacy: int):
    context.current_page.register_user(firstname, lastname, email, telephone, password, confirmed_pass, news, privacy, 1)
    assert context.current_page.check_input_text("first_name_field", "value", firstname, 1)
    assert context.current_page.check_input_text("last_name_field", "value", lastname, 1)
    assert context.current_page.check_input_text("email_field", "value", email, 1)
    assert context.current_page.check_input_text("telephone_field", "value", telephone, 1)
    assert context.current_page.check_input_text("password_field", "value", password, 1)
    assert context.current_page.check_input_text("password_confirmation_field", "value", confirmed_pass, 1)

    if news:
        assert context.current_page.check_element_selection("subscribe_yes_field", True, 1)
        assert context.current_page.check_element_selection("subscribe_no_field", False, 1)
    else:
        assert context.current_page.check_element_selection("subscribe_yes_field", False, 1)
        assert context.current_page.check_element_selection("subscribe_no_field", True, 1)

    if privacy:
        assert context.current_page.check_element_selection("privacy_policy_field", True, 1)
    else:
        assert context.current_page.check_element_selection("privacy_policy_field", False, 1)