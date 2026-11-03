from selenium.webdriver.common.by import By

from libraries.utils import StringUtils
from libraries.pages.BasePage import BasePage


class RegisterPage(BasePage):

    FIRST_NAME_INPUT =          (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(1) > div:nth-child(1) > input')
    LAST_NAME_INPUT =           (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(1) > div:nth-child(2) > input')
    EMAIL_INPUT =               (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(2) > input')
    USERNAME_INPUT =            (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(3) > input')
    PASSWORD_INPUT =            (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(4) > div:nth-child(1) > input')
    CONFIRM_PASSWORD_INPUT =    (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(4) > div:nth-child(2) > input')
    SUBMIT_BUTTON =             (By.CSS_SELECTOR, '#root main > div > div > form > button')
    PAGE_TITLE =                (By.CSS_SELECTOR, '#root main > div > div > div:nth-child(1) > h1')
    VERIFICATION_BUTTON =       (By.CSS_SELECTOR, '#root > div > main > div > div > div:nth-child(3) > button')
    ERROR_MESSAGE_TEMPLATE =    '//*[@id="root"]/div/main//div[contains(text(), "{}")]'

    def is_fully_rendered(self) -> bool:
        return self.is_visible(self.FIRST_NAME_INPUT, 3) \
        and    self.is_visible(self.LAST_NAME_INPUT, 1) \
        and    self.is_visible(self.LAST_NAME_INPUT, 1) \
        and    self.is_visible(self.EMAIL_INPUT, 1) \
        and    self.is_visible(self.USERNAME_INPUT, 1) \
        and    self.is_visible(self.PASSWORD_INPUT, 1) \
        and    self.is_visible(self.CONFIRM_PASSWORD_INPUT, 1) \
        and    self.is_visible(self.SUBMIT_BUTTON, 1)

    def populate_registration(self, first_name, last_name, email, username, password, confirm_password):
        self.type_text(self.FIRST_NAME_INPUT, first_name)
        self.type_text(self.LAST_NAME_INPUT, last_name)
        self.type_text(self.EMAIL_INPUT, email)
        self.type_text(self.USERNAME_INPUT, username)
        self.type_text(self.PASSWORD_INPUT, password)
        self.type_text(self.CONFIRM_PASSWORD_INPUT, confirm_password)

    def click_submit(self):
        self.click(self.SUBMIT_BUTTON)

    def error_is_visible(self, error):
        error_locator = StringUtils.combine_locator_template(By.XPATH, self.ERROR_MESSAGE_TEMPLATE, error)
        return self.is_visible(error_locator, 4)

    def on_code_verification_page(self, title):
        return self.is_visible(self.VERIFICATION_BUTTON, 3) and \
            self.has_text(self.PAGE_TITLE, title)

    def is_loaded(self) -> bool:
        return self.is_visible(self.USERNAME_INPUT)
