import logging
import os
from abc import abstractmethod, ABC

from selenium.common import TimeoutException
from selenium.webdriver import ActionChains
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

logger = logging.getLogger(__name__)


class BasePage(ABC):

    @property
    def BASE_URL(self) -> str:
        """Read base url from environment variables when needed."""
        return os.getenv("BASE_URL").rstrip("/")

    def __init__(self, driver, url):
        logger.debug("Page initializing.")
        self.driver = driver
        self.url_extension = url

    def open(self, url):
        """Navigate to a URL."""
        logger.debug(f"Opening link {url}")
        self.driver.get(url)

    def open_page(self):
        """Opens the page by combining the base url with the page path."""
        self.open(self.BASE_URL + self.url_extension)

    @abstractmethod
    def is_loaded(self) -> bool:
        """Checks for one element from the page to be visible."""
        pass

    @abstractmethod
    def is_fully_rendered(self) -> bool:
        """Checks for all required elements from the page to be visible."""
        pass

    @abstractmethod
    def error_is_visible(self, error):
        """Checks if the error is shown on the page."""
        pass

    def find(self, locator, timeout=1.0) -> WebElement:
        """Searches for presence of the element, scrolls to the element, checks if its visible,
        then returns the element.
        :raises: TimeoutException If the element is not located/visible before the specified timeout. """

        logger.debug(f"Function find called on element '{locator[1]}'")
        element = WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located(locator))
        ActionChains(self.driver).scroll_to_element(element).perform()
        return element

    def click(self, locator, timeout=1.0):
        """Check if element is clickable, then click it."""
        logger.debug(f"Function click called on element '{locator[1]}'")
        element = self.find(locator, timeout)
        WebDriverWait(self.driver, timeout).until(EC.element_to_be_clickable(element)).click()

    def type_text(self, locator, text, timeout=1.0):
        """Clear an element and type text into it."""
        logger.debug(f"Function type_text called on element '{locator[1]}'")
        element = self.find(locator, timeout)
        element.clear()
        element.send_keys(text)

    def wait_for_visible(self, locator, timeout=1.0):
        """Block until the element is visible."""
        logger.debug(f"Function wait_for_visible called on element '{locator[1]}'")
        self.find(locator, timeout)
        WebDriverWait(self.driver, timeout).until(EC.visibility_of_element_located(locator))

    def wait_for_text_in_element(self, locator, text, timeout=2.0):
        """Block until the element has the expected text."""
        logger.debug(f"Function wait_for_text_in_element called on element '{locator[1]}'")
        WebDriverWait(self.driver, timeout).until(EC.text_to_be_present_in_element(locator, text))

    def wait_for_page_loading(self, common_element_locator, timeout=3.0):
        """Block until element is stale, which means the old page got changed and the new page is loaded. """
        logger.debug(f"Function wait_for_page_loading called on element '{common_element_locator[1]}'")
        element = self.find(common_element_locator, timeout)
        WebDriverWait(self.driver, timeout).until(EC.staleness_of(element))

    def get_text(self, locator, timeout=1.0):
        """Return the text content of an element."""
        logger.debug(f"Function get_text called on element '{locator[1]}'")
        return self.find(locator, timeout).text

    def has_text(self, locator, text: str, timeout=1.0):
        """Return True if the element has the expected text inside, else False."""
        logger.debug(f"Function has_text called on element '{locator[1]}'")
        try:
            self.wait_for_text_in_element(locator, text, timeout)
            return True
        except TimeoutException:
            return False

    def is_visible(self, locator, timeout=2.0) -> bool:
        """Return True if the element is visible, False otherwise."""
        logger.debug(f"Function is_visible called on element '{locator[1]}'")
        try:
            self.wait_for_visible(locator, timeout)
            return True
        except TimeoutException:
            return False
