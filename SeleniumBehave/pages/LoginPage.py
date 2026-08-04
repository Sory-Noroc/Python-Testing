from selenium.webdriver.common.by import By
from core.BasePage import BasePage


class LoginPage(BasePage):

    locators = {
        "username_field": (By.XPATH, '//*[@id="input-email"]'),
        "password_field": (By.XPATH, '//*[@id="input-password"]'),
        "login_button"  : (By.XPATH, '//*[@id="content"]//input[contains(@value, "Login")]'),
    }
