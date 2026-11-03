from selenium import webdriver


class DriverFactory:
    """
        The factory class responsible for creating the browser to be used during the session.
        The _registry can be pre-populated with the relevant browsers.
        The browser is renewed for each test case.
        """

    _registry = {
        "chrome": webdriver.Chrome,
        "firefox": webdriver.Firefox,
        "edge": webdriver.Edge,
    }

    @classmethod
    def get_driver(cls, browser_name: str):
        driver_class = cls._registry.get(browser_name.lower())
        if not driver_class:
            raise ValueError(f"Driver browser '{driver_class}' misspelled or not implemented. Check DriverFactory.py!")
        return driver_class()