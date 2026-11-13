from libraries.pages.BasePage import BasePage
from libraries.pages.HomePage import HomePage
from libraries.pages.LoginPage import LoginPage
from libraries.pages.RegisterPage import RegisterPage


class PageFactory:
    """
    The factory class responsible for creating each page object when navigating to it.
    The _registry can be pre-populated with the relevant pages when writing the tests.
    """

    driver = None
    _registry = {
        "home": (HomePage, "/"),
        "register": (RegisterPage, "/register"),
        "login": (LoginPage, "/login")
    }

    @classmethod
    def get_page(cls, page_type: str) -> BasePage:
        page_class, url_extension = cls._registry.get(page_type.lower())
        if not page_class:
            raise ValueError(f"Page {page_type} misspelled or not implemented.")
        return page_class(cls.driver, url_extension)
