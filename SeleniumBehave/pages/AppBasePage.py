from abc import ABC
from selenium.common import TimeoutException
from selenium.webdriver.common.by import By
from core.BasePage import BasePage
import logging

logger = logging.getLogger(__name__)


class AppBasePage(BasePage, ABC):

    COMMON_LOCATORS = {
        "search_input": (By.XPATH, '//*[@id="search"]/input'),
        "search_button": (By.XPATH, '//*[@id="search"]/span/button'),
        "cart_button": (By.XPATH, '//*[@id="cart-total"]')
    }

    ADD_TO_CART_SELECTOR_TEMPLATE = (By.XPATH,
                           "//div[contains(@class, 'product-thumb')][.//a[text()='{name}']]//button[contains(@onclick, 'cart.add')]")
    REMOVE_FROM_CART_SELECTOR_TEMPLATE = (By.XPATH,
                            '//*[@id="cart"]//tr[.//a[text()="{name}"]]//button[contains(@onclick, "cart.remove")]')

    def __init__(self, driver, url_extension: str):
        """
        The pages have some common locators
        To avoid duplicate code and polluting BasePage, we create this intermediate Page Class
        Its purpose is to combine the common locators with the specific locators of each Page

        :param driver: Browser driver for the test
        :param url_extension: The specific part of the url for this page if accessible from url directly
        """
        super().__init__(driver, url_extension)
        page_specific_locators = getattr(self, 'LOCATORS', {})
        self.LOCATORS = {**self.COMMON_LOCATORS, **page_specific_locators}


    def add_product_to_cart_by_name(self, product_name: str, timeout: float):
        by, xpath_template = self.ADD_TO_CART_SELECTOR_TEMPLATE
        dynamic_selector = xpath_template.format(name=product_name)

        add_button = self.selenium.find_element_and_is_clickable((by, dynamic_selector), timeout)
        add_button.click()

    def remove_product_from_cart_by_name(self, product_name: str, timeout: float):
        by, xpath_template = self.REMOVE_FROM_CART_SELECTOR_TEMPLATE
        dynamic_selector = xpath_template.format(name=product_name)

        try:
            remove_button = self.selenium.find_element_and_is_clickable((by, dynamic_selector), timeout)
            remove_button.click()
        except TimeoutException as e:
            logger.error(f"Removal of product from cart failed. Was the dropdown open? Error: {e.msg}")

    def get_cart_status(self, timeout: float) -> str:
        """
        Extracts the text inside the cart span tag, of the form:
            <i class="fa fa-shopping-cart"></i> 2 item(s) - $483.99
        :param timeout: Seconds to wait for element to load
        :return: str
        """
        cart_element = self.selenium.find_element_is_visible(self.LOCATORS["cart_button"], timeout)
        cart_status = cart_element.text.split("</i>")[-1].strip()
        logger.info(f"Cart_status: {cart_status}")
        return cart_status

    def click_element_with_scroll(self, element: str, timeout: float):
        self.selenium.scroll_to_element(self.LOCATORS[element], timeout, with_click=True)