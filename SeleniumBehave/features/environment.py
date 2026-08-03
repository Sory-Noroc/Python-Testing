from behave.fixture import fixture, use_fixture_by_tag
from selenium import webdriver
from pages.Page import Page
from time import sleep

create_driver = lambda: webdriver.Chrome()

def before_scenario(context, scenario):
    context.driver = webdriver.Chrome()
    context.page = Page(context.driver)

def after_scenario(context, scenario):
    if hasattr(context, "driver"):
        context.driver.quit()

# @fixture
# def browser_driver(context):
#     # Setup
#     context.driver = create_driver()
#     context.page = Page(context.driver)
#     yield context.driver
#     # Teardown/cleanup
#     context.driver.quit()
#
# fixture_registry = {
#     "fixture.browser": browser_driver,
# }
#
# def before_tag(context, tag):
#     if tag.startswith("fixture."):
#         return use_fixture_by_tag(tag, context, fixture_registry)