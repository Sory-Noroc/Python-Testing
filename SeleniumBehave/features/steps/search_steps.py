from behave import *

@when(u'user enters "{product_name}" in search bar')
def search_for_product(context, product_name):
    context.current_page.search_for_product(product_name, timeout=1, with_enter=False)

@then('user should see "{product_name}" product')
def check_product_on_page(context, product_name):
    context.current_page.find_text_on_page(product_name, timeout=1)