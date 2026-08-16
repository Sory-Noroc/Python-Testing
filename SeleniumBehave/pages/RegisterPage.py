from selenium.common import TimeoutException
from selenium.webdriver.common.by import By

from core.BasePage import BasePage


class RegisterPage(BasePage):

    locators = {
        "first_name_field": (By.ID, "input-firstname"),
        "last_name_field": (By.ID, "input-lastname"),
        "email_field": (By.ID, "input-email"),
        "telephone_field": (By.ID, "input-telephone"),
        "password_field": (By.ID, "input-password"),
        "password_confirmation_field": (By.ID, "input-confirm"),
        "subscribe_yes_field": (By.CSS_SELECTOR, "#content > form > fieldset:nth-child(3) > div > div > label:nth-child(1) > input[type=radio]"),
        "subscribe_no_field": (By.CSS_SELECTOR, "#content > form > fieldset:nth-child(3) > div > div > label:nth-child(2) > input[type=radio]"),
        "privacy_policy_field": (By.CSS_SELECTOR, "#content > form div > input[type=checkbox]"),
        "continue_button": (By.CSS_SELECTOR, "#content > form div > input[type=submit]"),
        "error_field": (By.CSS_SELECTOR, "#account-register > div.alert.alert-danger.alert-dismissible > i")
    }

    def register_user(self,
                      firstname: str,
                      lastname: str,
                      email: str,
                      telephone: str,
                      password: str,
                      confirmed_password: str,
                      news: bool,
                      privacy: bool,
                      timeout: float
                ):
        self.text_field_input("first_name_field", firstname, timeout)
        self.text_field_input("last_name_field", lastname, timeout)
        self.text_field_input("email_field", email, timeout)
        self.text_field_input("telephone_field", telephone, timeout)
        self.text_field_input("password_field", password, timeout)
        self.text_field_input("password_confirmation_field", confirmed_password, timeout)

        if news:
            self.selenium.find_element_and_is_clickable(self.locators["subscribe_yes_field"], 1).click()
        else:
            self.selenium.find_element_and_is_clickable(self.locators["subscribe_no_field"], 1).click()

        if privacy:
            self.selenium.find_element_and_is_clickable(self.locators["privacy_policy_field"], 1).click()

    def check_input_text(self, locator_key: str, attribute: str, text: str, timeout: float) -> bool:
        self.selenium.find_element_attribute_text_matches(self.locators[locator_key], attribute, text, timeout)
        return True

    def check_element_is_invisible(self, locator: str, timeout: float) -> bool:
        try:
            self.selenium.find_element_is_not_visible(self.locators[locator], timeout)
        except TimeoutException:
            return False
        return True

    def get_error(self):
        error_element = self.selenium.find_element_is_visible(self.locators["error_field"], 1)
        self.logger.error(f"Attempt error: {error_element.text}")
        return error_element.text