from core.BasePage import BasePage
from pages import RegisterSuccessPage
from pages.AccountPage import AccountPage
from pages.HomePage import HomePage
from pages.LoginPage import LoginPage
from pages.RegisterPage import RegisterPage


class PageFactory:
    """
    The factory class responsible for creating each page object when navigating to it.
    The _registry can be pre-populated with the relevant pages when writing the tests.
    """

    driver = None
    _registry = {
        "home": (HomePage, "?route=common/home"),
        "login": (LoginPage, "?route=account/login"),
        "account": (AccountPage, "?route=account/account"),
        "register": (RegisterPage, "?route=account/register"),
        "register_success": (RegisterSuccessPage, "?route=account/success")
    }

    @classmethod
    def get_object(cls, page_type: str) -> BasePage:
        page_class, url_extension = cls._registry.get(page_type.lower())
        if not page_class:
            raise ValueError(f"Page {page_type} not implemented.")
        return page_class(cls.driver, url_extension)
