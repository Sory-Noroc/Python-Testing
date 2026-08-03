from pages.Page import Page
from selenium.webdriver.common.by import By

class HomePage(Page):
    ACCOUNT_LOGO_LOCATOR = (By.XPATH, '//*[@id="top-links"]//span[text()="My Account"]')
    LOGIN_BUTTON_LOCATOR = (By.XPATH, '//*[@id="top-links"]//a[text()="Login"]')
