from selenium.webdriver.common.by import By
from pages.AppBasePage import AppBasePage


class AccountPage(AppBasePage):

    LOCATORS = {
        "account_title": (By.XPATH, '//*[@id="content"]//h2[text()="My Account"]')
    }
