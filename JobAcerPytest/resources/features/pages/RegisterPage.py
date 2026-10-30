from selenium.webdriver.common.by import By
from resources.common.BasePage import BasePage


class RegisterPage(BasePage):

    FIRST_NAME_INPUT =          (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(1) > div:nth-child(1) > input')
    LAST_NAME_INPUT =           (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(1) > div:nth-child(2) > input')
    EMAIL_INPUT =               (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(2) > input')
    USERNAME_INPUT =            (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(3) > input')
    PASSWORD_INPUT =            (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(4) > div:nth-child(1) > input')
    CONFIRM_PASSWORD_INPUT =    (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(4) > div:nth-child(2) > input')
    SUBMIT_BUTTON =             (By.CSS_SELECTOR, '#root main > div > div > form > button')
    ERROR_MESSAGE =             (By.XPATH,        '//*[@id="root"]//main/div/div/div[2]')

    def is_fully_rendered(self) -> bool:
        self.wait_for_visible(self.FIRST_NAME_INPUT, 3)
        self.wait_for_visible(self.LAST_NAME_INPUT, 1)
        self.wait_for_visible(self.EMAIL_INPUT, 1)
        self.wait_for_visible(self.USERNAME_INPUT, 1)
        self.wait_for_visible(self.PASSWORD_INPUT, 1)
        self.wait_for_visible(self.CONFIRM_PASSWORD_INPUT, 1)
        self.wait_for_visible(self.SUBMIT_BUTTON, 1)
        return True

    def populate_registration(self, first_name, last_name, email, username, password, confirm_password):
        self.type_text(self.FIRST_NAME_INPUT, first_name)
        self.type_text(self.LAST_NAME_INPUT, last_name)
        self.type_text(self.EMAIL_INPUT, email)
        self.type_text(self.USERNAME_INPUT, username)
        self.type_text(self.PASSWORD_INPUT, password)
        self.type_text(self.CONFIRM_PASSWORD_INPUT, confirm_password)

    def click_submit(self):
        self.click(self.SUBMIT_BUTTON)

    def get_error(self) -> str:
        return self.get_text(self.ERROR_MESSAGE)

    def is_loaded(self) -> bool:
        return self.is_visible(self.USERNAME_INPUT)
