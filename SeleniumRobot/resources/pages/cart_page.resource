*** Settings ***
Resource    ../common.resource


*** Variables ***
${URL}                              https://demo.opencartmart.com/ordercoupon/index.php?route=checkout/cart

${CART_BUTTON}                      id=cart
${CART_ADD_FROM_HOME}               xpath=//*[@id="content"]//button[contains(@onclick, 'cart.add')]
${CART_TABLE_ITEM}                  xpath=//*[@id="content"]/form//tr
${PRODUCT_ADD_CART_BUTTON}          xpath=//div[contains(@class, 'product-thumb')][.//a[text()='{name}']]//button[contains(@onclick, 'cart.add')]
${CART_UPDATE_POPUP}                xpath=//*[@id="checkout-cart"]//div[contains(@class, 'alert-success')]
${CART_ERROR_POPUP}                 xpath=//*[@id="checkout-cart"]//div[contains(@class, 'alert-danger')]
${CART_QUANTITY_UPDATE_INPUT}       xpath=//*[@id="content"]/form//tr[.//a[text()="{name}"]]//input[contains(@name, 'quantity')]
${CART_QUANTITY_UPDATE_BUTTON}      xpath=//*[@id="content"]/form//tr[.//a[text()="{name}"]]//button[contains(@data-original-title, 'Update')]
${CART_REMOVE_BUTTON}               xpath=//*[@id="content"]/form//tr[.//a[text()="{name}"]]//button[contains(@data-original-title, 'Remove')]
${PRODUCT_REMOVE_CART_BUTTON}       xpath=//*[@id="cart"]//tr[.//a[text()="{name}"]]//button[contains(@onclick, "cart.remove")]
${VIEW_CART_BUTTON}                 xpath=//*[@id="cart"]//a[contains(normalize-space(.), "View Cart")]
${CHECKOUT_BUTTON}                  xpath=//*[@id="cart"]//a[contains(normalize-space(.), "Checkout")]

*** Keywords ***
