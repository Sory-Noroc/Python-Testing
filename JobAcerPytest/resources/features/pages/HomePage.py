from selenium.webdriver.common.by import By
from resources.common.BasePage import BasePage


class HomePage(BasePage):
    base_url = "https://jobacer.sorinnoroc.com"
    URL = "/"

    MAIN_TITLE         = (By.XPATH, '//*[@id="root"]/div/main/div/section[1]/div/h1')
    GET_STARTED_BUTTON = (By.XPATH, '//*[@id="root"]/div/main/div/section[1]/div/div[2]/a[1]/button')

    def is_loaded(self) -> bool:
        self.wait_for_visible(self.MAIN_TITLE, 3)
        return True

    def is_fully_rendered(self) -> bool:
        self.wait_for_visible(self.MAIN_TITLE, 3)
        self.wait_for_visible(self.GET_STARTED_BUTTON, 1)
        return True

    def get_error(self) -> str:
        raise NotImplementedError("Function not implemented yet.")

