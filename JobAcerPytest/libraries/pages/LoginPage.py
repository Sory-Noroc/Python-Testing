from selenium.webdriver.common.by import By
from libraries.pages.BasePage import BasePage
from libraries.utils import StringUtils


class LoginPage(BasePage):
    LOGIN_INPUT =               (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(1) > input')
    PASSWORD_INPUT =            (By.CSS_SELECTOR, '#root main > div > div > form > div:nth-child(2) > input')
    SUBMIT_BUTTON =             (By.CSS_SELECTOR, '#root main > div > div > form > button')
    ERROR_FIELD =               (By.CSS_SELECTOR, '#root main > div > div > div > div')
    ERROR_MESSAGE_TEMPLATE =    '//*[@id="root"]/div/main//div[contains(text(), "{}")]'


    def is_fully_rendered(self) -> bool:
        return self.is_visible(self.LOGIN_INPUT) and \
            self.is_visible(self.PASSWORD_INPUT) and \
            self.is_visible(self.SUBMIT_BUTTON)

    def click_submit(self):
        self.click(self.SUBMIT_BUTTON)

    def populate_inputs(self, login: str, password: str):
        self.type_text(self.LOGIN_INPUT, login)
        self.type_text(self.PASSWORD_INPUT, password)

    def error_is_visible(self, error):
        error_locator = StringUtils.combine_locator_template(By.XPATH, self.ERROR_MESSAGE_TEMPLATE, error)
        return self.is_visible(error_locator, 4)

    def is_loaded(self) -> bool:
        return self.is_visible(self.LOGIN_INPUT)
