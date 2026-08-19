from behave import *

@when(u'user enters "{product_name}" in search bar')
def search_for_product(context, product_name):
    context.current_page.search_for_product(product_name, timeout=1, with_enter=False)

@when('user enters "{product_name}" + Enter in search bar')
def step_impl(context, product_name):
    context.current_page.search_for_product(product_name, timeout=1, with_enter=True)

@then('user should see product "{product_name}"')
def check_product_on_page(context, product_name):
    context.current_page.find_text_on_page(product_name, timeout=1)
