from pages.Page import Page
from selenium.webdriver.common.by import By

class LoginPage(Page):
    USERNAME_FIELD_LOCATOR = (By.XPATH, '//*[@id="input-email"]')
    PASSWORD_FIELD_LOCATOR = (By.XPATH, '//*[@id="input-password"]')
    LOGIN_BUTTON_LOCATOR = (By.XPATH, '//*[@id="content"]//input[contains(@value, "Login")]')