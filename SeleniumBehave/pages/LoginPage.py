from pages.Page import Page
from selenium.webdriver.common.by import By

class LoginPage(Page):
    # USERNAME_FIELD_LOCATOR = (By.ID, "user-name")
    # PASSWORD_FIELD_LOCATOR = (By.ID, "password")
    # LOGIN_BUTTON_LOCATOR = (By.ID, "login-button")

    locators = {
        "username_field": (By.ID, "user-name"),
        "password_field": (By.ID, "password"),
        "login_button": (By.ID, "login-button"),
    }

    # def enter_username(self, username):
    #     self.find_element_and_is_clickable(self.LOGIN_BUTTON_LOCATOR, 3)
    #     self.enter_text(self.USERNAME_FIELD_LOCATOR, username, 2)
