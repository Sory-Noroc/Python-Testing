from selenium.common import TimeoutException, ElementNotInteractableException
from selenium.webdriver import Keys

from core.BasePage import BasePage
from selenium.webdriver.common.by import By


class HomePage(BasePage):

    locators = {
        "page_title"  : (By.XPATH, '//*[@id="logo"]//a[text()="Your Store"]'),
        "account_logo": (By.XPATH, '//*[@id="top-links"]//span[text()="My Account"]'),
        "login_button": (By.XPATH, '//*[@id="top-links"]//a[text()="Login"]'),
        "register_button": (By.XPATH, '//*[@id="top-links"]//a[text()="Register"]'),
        "logout_button": (By.XPATH, '//*[@id="top-links"]/a[text()="Logout"]'),
        "search_input": (By.XPATH, '//*[@id="search"]/input'),
        "search_button": (By.XPATH, '//*[@id="search"]/span/button')
    }

    def confirm_page_is_opened(self):
        self.selenium.find_element_is_visible(self.locators["page_title"], 1)
        self.selenium.find_element_and_is_clickable(self.locators["account_logo"], 1)
        return True

    def search_for_product(self, product_name: str, timeout: float, with_enter: bool = False):
        input_field = self.selenium.find_element_and_is_clickable(self.locators["search_input"], timeout)
        input_field.send_keys(product_name)
        if with_enter:
            input_field.send_keys(Keys.ENTER)
