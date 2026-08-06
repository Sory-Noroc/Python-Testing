from abc import ABC, abstractmethod
import os

from selenium.common import ElementNotVisibleException, TimeoutException
from selenium.webdriver.ie.webdriver import WebDriver
from core.SeleniumEngine import SeleniumEngine
import logging


class BasePage(ABC):

    def __init__(self, driver: WebDriver, url_extension: str):
        self.driver = driver
        self.selenium = SeleniumEngine(driver)
        self.url_extension = url_extension
        self.logger = logging.getLogger(self._class())
        self.logger.info(f"{self._class()} initialized.")

    @property
    def base_url(self) -> str:
        """ Reads the base url from environment variables or throws an IOError """
        base_url = os.getenv("BASE_URL", "").rstrip("/")
        if base_url:
            return base_url
        else:
            self.logger.error("Base URL not set.")
            raise IOError("BASE_URL not set in environment variables.")

    @property
    def page_url(self) -> str:
        """ Property of page url """
        path = self.url_extension.lstrip("/")
        if path:
            self.logger.info("page_url path concatenated.")
            return f"{self.base_url}/{path}"
        else:
            self.logger.info("url_extension not set.")
            return self.base_url

    @property
    @abstractmethod
    def locators(self) -> dict:
        """ Abstract property of page locators """
        pass

    def open(self):
        self.driver.get(self.page_url)
        self.logger.debug(f"Page url: {self.page_url} opened.")

    def _class(self):
        return self.__class__.__name__

    def confirm_page_is_opened(self) -> bool:
        for key, locator in self.locators.items():
            try:
                self.selenium.find_element_is_visible(locator, 1)
                self.logger.debug(f"Locator: {key} found and is visible.")
            except ElementNotVisibleException:
                self.logger.error(f"Locator: {key} not visible.")
            except TimeoutException:
                self.logger.error(f"Locator: {key} not found on page.")
        return True

    def element_click(self, element_name: str, timeout: float):
        self.logger.info(f"Element click triggered for {element_name}.")

        if element_name not in self.locators.keys():
            self.logger.error(f"Element name: {element_name} not found in locators.")
            raise ValueError(f"Element name: {element_name} not found in locators.")

        element = self.selenium.find_element_and_is_clickable(self.locators[element_name], timeout)
        self.logger.info(f"Element to be clicked found: {element_name}.")
        element.click()
        self.logger.info(f"Click performed for element: {element_name}.")

    def text_field_input(self, element_name: str, text_input: str, timeout: float):
        self.logger.info(f"Text input triggered for {element_name}.")
        self.selenium.find_element_is_visible(self.locators[element_name], timeout)
        self.selenium.enter_text(self.locators[element_name], text_input, timeout)
        self.logger.info(f"Input field population finished for {element_name} with text: {text_input}.")

    def check_element_selection(self, element_name: str, selection: bool, timeout: float) -> bool:
        if selection:
            self.selenium.check_element_is_selected(self.locators[element_name], timeout)
            return True
        else:
            try:
                self.selenium.check_element_is_selected(self.locators[element_name], timeout)
                return False
            except TimeoutException:
                return True