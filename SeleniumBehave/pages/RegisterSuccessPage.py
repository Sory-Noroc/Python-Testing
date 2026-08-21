from selenium.webdriver.common.by import By
from core.BasePage import BasePage


class RegisterSuccessPage(BasePage):
    LOCATORS = {
        "page_title": (By.XPATH, '//*[@id="content"]/h1'),
        "continue_button": (By.XPATH, '//*[@id="content"]//a[text()="Continue"]'),
    }
