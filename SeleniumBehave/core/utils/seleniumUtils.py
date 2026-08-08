from selenium import webdriver


def create_driver(driver="chrome"):
    if driver == "chrome":
        return webdriver.Chrome()
    elif driver == "firefox":
        return webdriver.Firefox()
    elif driver == "edge":
        return webdriver.Edge()
    else:
        raise ValueError(f"Requested driver '{driver}' not supported or typo in name.")
