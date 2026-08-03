from behave.fixture import fixture, use_fixture_by_tag
from selenium import webdriver
from pages.Page import Page
from time import sleep

create_driver = lambda: webdriver.Chrome()
username = "sorinnoroc1@gmail.com"
password = "sorin.noroc"

def before_scenario(context, scenario):
    context.driver = webdriver.Chrome()
    context.driver.maximize_window()
    context.page = Page(context.driver)
    context.username = username
    context.password = password

def after_scenario(context, scenario):
    if hasattr(context, "driver"):
        context.driver.quit()