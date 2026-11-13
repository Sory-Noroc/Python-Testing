import os
import logging
import shutil
import subprocess
import allure
from behave import fixture, use_fixture
from dotenv import load_dotenv

from libraries.api.user_service import UserService
from libraries.db.database_helper import DatabaseHelper
from libraries.utils.DriverFactory import DriverFactory
from libraries.utils.PageFactory import PageFactory

logger = logging.getLogger(__name__)


@fixture
def create_browser(context):
    context.browser = context.config.userdata.get("BROWSER")
    context.driver = DriverFactory.get_driver(context.browser)
    context.driver.maximize_window()
    PageFactory.driver = context.driver
    yield context.driver
    # CLEANUP
    context.driver.quit()


def before_all(context):
    logging.basicConfig(filename="./results/debug.log", filemode="a", level=logging.INFO)
    load_dotenv()

    base_url = context.config.userdata.get("BASE_URL")
    uac_url = context.config.userdata.get("UAC_URL")
    interview_url = context.config.userdata.get("INTERVIEW_URL")
    os.environ["BASE_URL"] = base_url
    os.environ["UAC_URL"] = uac_url
    os.environ["INTERVIEW_URL"] = interview_url

    context.database = DatabaseHelper()

    # Clean previous test results
    shutil.rmtree("results/allure-results")
    os.mkdir("results/allure-results")

    use_fixture(create_browser, context)


def before_scenario(context, scenario):
    uac_url = os.getenv("UAC_URL")
    context.user_service = UserService(uac_url)


def after_step(context, step):
    if step.status == "failed" and hasattr(context, "driver"):
        allure.attach(
            context.driver.get_screenshot_as_png(),
            name=f"Screenshot_Failed_For_{step.name}",
            attachment_type=allure.attachment_type.PNG,
        )


def after_all(context):
    results_dir = "results/allure-results"
    report_dir = "results/allure-report"

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
    logging.shutdown()
