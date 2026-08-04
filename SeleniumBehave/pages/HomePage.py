from selenium.common import TimeoutException, ElementNotInteractableException
from core.BasePage import BasePage
from selenium.webdriver.common.by import By


class HomePage(BasePage):

    locators = {
        "page_title"  : (By.XPATH, '//*[@id="logo"]//a[text()="Your Store"]'),
        "account_logo": (By.XPATH, '//*[@id="top-links"]//span[text()="My Account"]'),
        "login_button": (By.XPATH, '//*[@id="top-links"]//a[text()="Login"]'),
        "logout_button": (By.XPATH, '//*[@id="top-links"]/a[text()="Logout"]')
    }

    def confirm_page_is_opened(self):
        self.selenium.find_element_is_visible(self.locators["page_title"], 1)
        self.selenium.find_element_and_is_clickable(self.locators["account_logo"], 1)
        return True
