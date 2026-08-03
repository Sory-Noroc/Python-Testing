from pages.Page import Page
from selenium.webdriver.common.by import By

class AccountPage(Page):
    ACCOUNT_HEADING_LOCATOR = (By.XPATH, '//*[@id="content"]//h2[text()="My Account"]')