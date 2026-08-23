from behave import given, when, then


"""
    :param text: Status of the cart
    of the form "0 item(s) - $0.00"
"""
@then(u'user should see cart status "{text}"')
def text_is_in_cart(context, text):
    context.current_page.find_text_in_cart(text, 1)


@when(u'user adds product "{product_name}" to cart')
def add_specific_product_to_cart(context, product_name):
    context.current_page.add_product_to_cart_by_name(product_name, 1)