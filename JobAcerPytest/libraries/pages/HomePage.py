from selenium.webdriver.common.by import By
from libraries.pages.BasePage import BasePage


class HomePage(BasePage):

    MAIN_TITLE         = (By.XPATH, '//*[@id="root"]/div/main/div/section[1]/div/h1')
    GET_STARTED_BUTTON = (By.XPATH, '//*[@id="root"]/div/main/div/section[1]/div/div[2]/a[1]/button')
    USERNAME_SPAN      = (By.XPATH, '//*[@id="root"]/div/nav/div/div[3]/div/a/span')
    ADMIN_BUTTON       = (By.XPATH, '//*[@id="root"]/div/nav/div/div[2]/a[1]')

    def is_loaded(self) -> bool:
        self.wait_for_visible(self.MAIN_TITLE, 3)
        return True

    def is_fully_rendered(self) -> bool:
        return self.is_visible(self.MAIN_TITLE, 3) and \
                self.is_visible(self.GET_STARTED_BUTTON, 1)


    def is_admin_button_visible(self) -> bool:
        return self.is_visible(self.ADMIN_BUTTON, 2)

    def get_logged_username(self) -> str:
        return self.get_text(self.USERNAME_SPAN)

    def check_error(self, error):
        raise NotImplementedError("Function not implemented yet.")

    def error_is_visible(self, error):
        raise NotImplementedError("Function not implemented yet.")
