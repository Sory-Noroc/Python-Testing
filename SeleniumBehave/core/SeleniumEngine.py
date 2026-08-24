import logging

from selenium.webdriver import ActionChains
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

logger = logging.getLogger(__name__)

class SeleniumEngine:
    def __init__(self, driver):
        self.driver = driver
        logger.info(f"Selenium engine initialized for {driver}.")

    def navigate_to(self, url):
        self.driver.get(url)
        logger.info(f"Navigate to {url}.")

    def find_element_is_visible(self, locator, timeout: float):
        logger.info(f"Looking for element {locator} to be visible for {timeout}sec.")
        return WebDriverWait(self.driver, timeout).until(EC.visibility_of_element_located(locator))

    def find_element_is_not_visible(self, locator, timeout: float):
        logger.info(f"Looking for element {locator} to be not visible for {timeout}sec.")
        WebDriverWait(self.driver, timeout).until(EC.invisibility_of_element_located(locator))

    def find_element_text_matches(self, locator, text: str, timeout: float):
        logger.info(f"Looking for element {locator} to have inside the text '{text}'.")
        return WebDriverWait(self.driver, timeout).until(EC.text_to_be_present_in_element(locator, text))

    def find_element_text_partially_matches(self, locator, partial_match: str, timeout: float):
        logger.info(f"Looking for element {locator} to partially have inside the text '{partial_match}'.")
        element = WebDriverWait(self.driver, timeout).until(EC.visibility_of_element_located(locator))
        return partial_match in element.text

    def find_element_attribute_text_matches(self, locator, attribute: str, expected_text: str, timeout: float):
        logger.info(f"Looking for element {locator} to have inside the attribute '{attribute}' the text '{expected_text}'.")
        return WebDriverWait(self.driver, timeout).until(EC.text_to_be_present_in_element_attribute(locator, attribute, expected_text))

    def find_element_and_is_clickable(self, locator, timeout: float):
        logger.info(f"Looking for element {locator} to be clickable for {timeout}sec.")
        return WebDriverWait(self.driver, timeout).until(EC.element_to_be_clickable(locator))

    def check_element_is_selected(self, locator, timeout: float):
        logger.info(f"Looking for element {locator} to be selected for {timeout}sec.")
        element = WebDriverWait(self.driver, timeout).until(EC.visibility_of_element_located(locator))
        WebDriverWait(self.driver, timeout).until(EC.element_to_be_selected(element))

    def find_element_is_located(self, locator, timeout: float):
        """
        Waits for element to be loaded on the page then returns it.

        :param locator: Selenium selector of page element.
        :param timeout: Wait time for element to be loaded.

        :return: The found WebElement.

        :raises: TimeoutException if the element was not found.
        """
        logger.info(f"Looking for element {locator} to be located for {timeout}sec.")
        return WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located(locator))

    def find_text(self, locator, text: str, timeout: float):
        logger.info(f"Looking for element {locator} to have the text: {text}.")
        return WebDriverWait(self.driver, timeout).until(EC.text_to_be_present_in_element(locator, text))

    def enter_text(self, locator, text: str, timeout: float):
        """
        On the opened page of interest, finds the element,
        checks if it is clickable, then enters the text into the element.
        Clickable check is done to simulate user experience.

        :param locator: Selenium selector of page element.
        :param text: Text to be entered.
        :param timeout: Wait time for element to be clickable.

        :return: The populated element.
        """
        logger.info(f"Looking for element {locator} to be clickable for {timeout}sec.")
        element: WebElement = self.find_element_and_is_clickable(locator, timeout=timeout)
        element.clear()
        element.send_keys(text)
        logger.info(f"Entered the text '{text}' into the element '{locator}'.")
        return element

    def scroll_to_element(self, locator, timeout: float, with_click: bool = False):
        logger.info(f"Scrolling to element {locator}.")
        element: WebElement = self.find_element_is_located(locator, timeout=timeout)
        ActionChains(self.driver).scroll_to_element(element).perform()
        if with_click:
            element.click()
