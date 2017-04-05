package me.khyen;

import cucumber.api.java.en.When;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.Given;
import cucumber.api.java.Before;
import cucumber.api.java.After;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;

public class StepDefinitions {

	@Before
	public void setup() throws InterruptedException, IOException {
		System.setProperty("webdriver.chrome.driver", "build/resources/test/chrome/mac64/chromedriver");

		webDriver = new ChromeDriver();

		String jsonString = FileUtils.readFileToString(locatorsFile, Charset.defaultCharset());
		
		jsonLocators = new JSONObject(jsonString);
	}

	@After
	public void teardown() {
		webDriver.quit();
	}

	// Step Definitions

	@Given("^I sign in to Liferay Portal as \"([^\"]*)\"$")
	public void I_sign_in_to_Liferay_Portal_as() {
		webDriver.get("http://localhost:8080");

		click("link","Sign In");
		input("text_field","Email Address","test@liferay.com");
		input("text_field","Password","test");
		click("button","Sign In");
	}

	@Then("^I should be signed in$")
	public void i_should_be_signed_in() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
	}
	
	@Given("^I visit \"([^\"]*)\"$")
	public void I_visit(String url) {
		webDriver.get(url);
	}

	@When("^I click the \"([^\"]*)\" \"([^\"]*)\"$")
	public void I_click_the(String label, String object) {
		click(object, label);
	}

	@When("^I fill in \"([^\"]*)\" with \"([^\"]*)\"$")
	public void I_fill_in_with(String label, String text) {
		input("text_field", label, text);
	}

	@When("^I switch to active modal$")
	public void I_switch_to_active_modal() {
		webDriver.switchTo().activeElement();
	}

	@When("^I sleep for (\\d+) milliseconds$")
	public void I_sleep_for(int milliseconds) {
		sleep(milliseconds);
	}

	// Functions

	public void click(String type, String label) {
		String path = jsonLocators.getJSONObject(type).getString("xpath");

		path = path.replace("{access_name}", label);

		webDriver.findElement(By.xpath(path)).click();

		sleep(1000);
	}

	public void input(String type, String label, String text) {
		String path = jsonLocators.getJSONObject(type).getString("xpath");

		path = path.replace("{access_name}", label);

		webDriver.findElement(By.xpath(path)).clear();
		webDriver.findElement(By.xpath(path)).sendKeys(text);
	}

	public void sleep(long milliseconds) {
		try {
			Thread.sleep(milliseconds);
		}
		catch (InterruptedException ie) {
			// Do nothing
		}
	}

	protected WebDriver webDriver;
	protected File locatorsFile = new File("../locators/base.json");
	protected JSONObject jsonLocators;

}
