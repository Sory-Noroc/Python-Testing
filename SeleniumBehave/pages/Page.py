from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By


class Page:
    def __init__(self, driver):
        self.driver = driver

    def navigate_to(self, url):
        self.driver.get(url)

    def find_element_is_visible(self, locator, timeout: float):
        return WebDriverWait(self.driver, timeout).until(EC.visibility_of_element_located(locator))

    def find_element_is_not_visible(self, locator, timeout: float):
        WebDriverWait(self.driver, timeout).until(EC.invisibility_of_element_located(locator))

    def find_element_text_matches(self, locator, text: str, timeout: float):
        return WebDriverWait(self.driver, timeout).until(EC.text_to_be_present_in_element(locator, text))

    def find_element_attribute_text_matches(self, locator, attribute: str, text: str, timeout: float):
        return WebDriverWait(self.driver, timeout).until(EC.text_to_be_present_in_element_attribute(locator, attribute, text))

    def find_element_and_is_clickable(self, locator, timeout: float):
        return WebDriverWait(self.driver, timeout).until(EC.element_to_be_clickable(locator))

    def check_element_is_selected(self, locator, timeout: float):
        return WebDriverWait(self.driver, timeout).until(EC.element_to_be_selected(locator))

    def find_element_is_located(self, locator, timeout: float):
        """
        Waits for element to be loaded on the page then returns it.

        :param locator: Selenium selector of page element.
        :param timeout: Wait time for element to be loaded.

        :return: The found WebElement.

        :raises: TimeoutException if the element was not found.
        """
        return WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located(locator))

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
        element: WebElement = self.find_element_and_is_clickable(locator, timeout=timeout)
        element.clear()
        element.send_keys(text)
        return element
