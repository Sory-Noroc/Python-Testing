from selenium.webdriver.common.by import By
from core.BasePage import BasePage


class RegisterSuccessPage(BasePage):
    locators = {
        "page_title": (By.XPATH, "#content > h1"),
        "continue_button": (By.XPATH, "#content a[text()='Continue']"),
    }
