from abc import ABC

from selenium.webdriver.common.by import By

from core.BasePage import BasePage


class AppBasePage(BasePage, ABC):

    COMMON_LOCATORS = {
        "search_input": (By.XPATH, '//*[@id="search"]/input'),
        "search_button": (By.XPATH, '//*[@id="search"]/span/button')
    }

    def __init__(self, driver, url_extension: str):
        """
        The pages have some common locators
        To avoid duplicate code and polluting BasePage, we create this intermediate Page Class
        Its purpose is to combine the common locators with the specific locators of each Page

        :param driver: Browser driver for the test
        :param url_extension: The specific part of the url for this page if accessible from url directly
        """
        super().__init__(driver, url_extension)
        page_specific_locators = getattr(self, 'LOCATORS', {})
        self.LOCATORS = {**self.COMMON_LOCATORS, **page_specific_locators}