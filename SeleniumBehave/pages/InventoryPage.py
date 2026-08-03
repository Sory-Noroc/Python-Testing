from selenium.webdriver.common.by import By

from pages.Page import Page


class InventoryPage(Page):
    locators = {
        "products_label": (By.CSS_SELECTOR, "#header_container > div.header_secondary_container > span")
    }