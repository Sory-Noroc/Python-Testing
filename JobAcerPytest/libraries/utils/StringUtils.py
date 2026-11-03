from typing import Literal

from selenium.webdriver.common.by import By


def combine_locator_template(by, locator_template: str, *args) -> tuple[Literal, str]:
    locator_string = locator_template.format(*args)
    # Returns a tuple by default
    return by, locator_string