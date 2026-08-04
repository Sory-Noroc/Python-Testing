from selenium.webdriver.common.by import By
from core.BasePage import BasePage


class LoginPage(BasePage):

    locators = {
        "username_field": (By.XPATH, '//*[@id="input-email"]'),
        "password_field": (By.XPATH, '//*[@id="input-password"]'),
        "login_button"  : (By.XPATH, '//*[@id="content"]//input[contains(@value, "Login")]'),
        "error_label"   : (By.XPATH, '//*[@id="account-login"]/div[1]')
    }

    def get_error(self):
        error_element = self.selenium.find_element_is_visible(self.locators["error_label"], 1)
        self.logger.error(f"Attempt error: {error_element.text}")
        return error_element.text

    def confirm_page_is_opened(self) -> bool:
        self.selenium.find_element_is_visible(self.locators["username_field"], 1)
        self.selenium.find_element_is_visible(self.locators["password_field"], 1)
        self.selenium.find_element_is_visible(self.locators["login_button"], 1)
        return True
