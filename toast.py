import com.kms.katalon.core.mobile.keyword.internal.MobileDriverFactory
import io.appium.java_client.AppiumDriver
import com.kms.katalon.core.util.KeywordUtil
from appium.webdriver.webelement import WebElement

def toast(toastMsg):
    AppiumDriver<WebElement> driver = MobileDriverFactory.getDriver()
    toast1 = driver.findElementByXPath("//android.widget.Toast[@text='" + toastMsg + "']")
    println("Toast element: " + toast1)
    if (toast1 == null):
        KeywordUtil.markFailed('ERROR: Toast object not found!')