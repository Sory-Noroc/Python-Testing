from behave import when, then
from libraries.pages.RegisterPage import RegisterPage


@when('user registers with "{first_name}", "{last_name}", "{email}", "{username}", "{password}" and "{pass_confirmation}"')
def register_user(context, first_name, last_name, email, username, password, pass_confirmation):
    page: RegisterPage = context.current_page
    page.populate_registration(
        first_name=first_name,
        last_name=last_name,
        username=username,
        email=email,
        password=password,
        confirm_password=pass_confirmation
    )

@when('user clicks "Create Account"')
def create_account(context):
    page: RegisterPage = context.current_page
    page.click_submit()

@then('user is on the code verification page')
def verify_page_visible(context):
    page: RegisterPage = context.current_page
    assert page.on_code_verification_page("Verify Your Account")

@then('user is not on the code verification page')
def verify_page_not_visible(context):
    page: RegisterPage = context.current_page
    assert not page.on_code_verification_page("Verify Your Account")