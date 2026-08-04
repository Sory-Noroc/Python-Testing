from core.BasePage import BasePage
from selenium.webdriver.common.by import By

class AccountPage(BasePage):

    locators = {
        "account_title": (By.XPATH, '//*[@id="content"]//h2[text()="My Account"]')
    }
