import subprocess
import allure
from selenium import webdriver
import os
import logging
import pytest
from pages.PageFactory import PageFactory

pytest.register_assert_rewrite("features.steps")
logging.basicConfig(filename="./reports/opencart.log", filemode="w", level=logging.INFO)
logger = logging.getLogger(__name__)

def after_step(context, step):
    if step.status == "failed" and hasattr(context, "driver"):
        allure.attach(
            context.driver.get_screenshot_as_png(),
            name=f"Screenshot_Failed_For_{step.name}",
            attachment_type=allure.attachment_type.PNG,
        )

def before_scenario(context, scenario):
    context.driver = webdriver.Chrome()
    context.driver.maximize_window()
    PageFactory.driver = context.driver
    os.environ["BASE_URL"] = context.config.userdata.get("BASE_URL")

def after_scenario(context, scenario):
    if hasattr(context, "driver"):
        context.driver.quit()


def after_all(context):
    results_dir = "reports/allure-results"
    report_dir = "reports/allure-report"

    if os.path.exists(results_dir):
        try:
            logger.info("[ALLURE] Generating report...")
            subprocess.run(
                f"allure generate {results_dir} -o {report_dir} --clean",
                shell=True,
                check=True
            )
            logger.info(f"[ALLURE] Report generated successfully at: {os.path.abspath(report_dir)}")
        except subprocess.CalledProcessError as e:
            logger.error(f"[ALLURE] Failed to generate report. Ensure Allure CLI is installed and in PATH. Error: {e}")