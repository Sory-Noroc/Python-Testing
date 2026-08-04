import allure
from selenium import webdriver
import os
import logging
from pages.PageFactory import PageFactory

logging.basicConfig(filename="./reports/opencart.log", level=logging.INFO)

def before_scenario(context, scenario):
    context.driver = webdriver.Chrome()
    context.driver.maximize_window()
    PageFactory.driver = context.driver
    os.environ["BASE_URL"] = context.config.userdata.get("BASE_URL")

def after_step(context, step):
    if step.status == "failed" and hasattr(context, "driver"):
        allure.attach(
            context.driver.get_screenshot_as_png(),
            name=f"Screenshot_Failed_For_{step.name}",
            attachment_type=allure.attachment_type.PNG,
        )


def after_scenario(context, scenario):
    if hasattr(context, "driver"):
        context.driver.quit()