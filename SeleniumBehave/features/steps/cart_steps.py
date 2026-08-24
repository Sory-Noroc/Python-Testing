from behave import given, when, then
from selenium.common import TimeoutException

@when(u'user adds product "{product_name}" to cart')
def add_specific_product_to_cart(context, product_name):
    context.current_page.add_product_to_cart_by_name(product_name, 1)

@when(u'user deletes "{product_name}" from cart')
def remove_specific_product_from_cart(context, product_name):
    context.current_page.remove_product_from_cart_by_name(product_name, 2)

@when(u'user clicks the cart button')
def cart_button_click(context):
    context.current_page.click_element_with_scroll("cart_button", 2)

@then(u'user should see cart status "{text}"')
def text_is_in_cart(context, text):
    """
        :param context: behave object containing the current page object instance
        :param text: Status of the cart of
        the form "0 item(s) - $0.00"
    """
    status = context.current_page.get_cart_status(1)
    assert text == status, f"status should be {text}, but it's actually {status}."

@then(u'user should see empty cart')
def check_if_cart_is_empty(context):
    status = context.current_page.get_cart_status(1)
    assert "0 item(s) - $0.00" == status, f"status should be empty but it's actually {status}."
