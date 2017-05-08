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
		System.setProperty("webdriver.chrome.driver", "build/resources/test/chrome/win64/chromedriver.exe");

		webDriver = new ChromeDriver();

		String jsonString = FileUtils.readFileToString(locatorsFile, Charset.defaultCharset());
		
		jsonLocators = new JSONObject(jsonString);
	}

	@After
	public void teardown() {
		webDriver.quit();
	}

	/*
	Step Definitions
	*/

	@Given("^I sign in to Liferay Portal as \"([^\"]*)\"$")
	public void signIntoPortalAs() {
		webDriver.get("http://localhost:8080");

		click("link","Sign In");
		input("text_field","Email Address","test@liferay.com");
		input("text_field","Password","test");
		click("button","Sign In");
	}

	@Then("^I should be signed in$")
	public void shouldBeSignedIn() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
	}
	
	@Given("^I visit \"([^\"]*)\"$")
	public void iVisit(String url) {
		webDriver.get(url);
	}

	@When("^I click the \"([^\"]*)\" \"([^\"]*)\"$")
	public void iClick(String label, String object) {
		click(object, label);
	}

	@When("^I fill in \"([^\"]*)\" with \"([^\"]*)\"$")
	public void fillIn(String label, String text) {
		input("text_field", label, text);
	}

	@When("^I switch to active modal$")
	public void switchToActiveModal() {
		webDriver.switchTo().activeElement();
	}

	@When("^I open the Product Side Bar$")
	public void openProductSideBar() {
		int attempts = 0;
		do {sleep(1000);} while (!hasXPath("product_menu_control_panel") && (attempts++ <= 10));

		click("product_menu_toggle", "");
	}

	@When("^I expand the \"([^\"]*)\" panel$")
	public void expandPanel(String accessName) {
		int attempts = 0;
		do {sleep(1000);} while (!hasXPath(xpath("product_menu_collapsed_panel", accessName)) && (attempts++ <= 10));

		click("product_menu_panel_title", accessName);
	}

	@When("^I expand the \"([^\"]*)\" submenu$")
	public void expandSubmenu(String accessName) {
		int attempts = 0;
		do {sleep(1000);} while (!hasXPath(xpath("product_menu_collapsed_submenu", accessName)) && (attempts++ <= 10));

		click("link", accessName);
	}

	@When("^I open the \"([^\"]*)\" ellipsis menu$")
	public void openEllipsisMenu(String menu_item) {
		// TODO
	}

	@When("^I select \"([^\"]*)\" from the dropdown menu$")
	public void selectFromDropdown(String menu_item) {
		// TODO
	}

	@Then("^I should see the success message$")
	public void expectSuccess() {
		// TODO: Call isSuccess
	}

	/*
	Misc Steps
	*/

	@When("^I sleep for (\\d+) milliseconds$")
	public void I_sleep_for(int milliseconds) {
		sleep(milliseconds);
	}

	/*
	Helper Functions
	*/

	private String xpath(String type, String accessName) {
		return jsonLocators.getJSONObject(type).getString(accessName);
	}

	private boolean hasXPath(String path) {
		try {
			webDriver.findElement(By.xpath(path));
			return true;
		}
		catch (Exception e) {
			return false;
		}
	}

//	private boolean isSuccess() {
//		// TODO: Check for success message, and return bool
//	}

	private void click(String type, String label) {
		String path = jsonLocators.getJSONObject(type).getString("xpath");

		path = path.replace("{access_name}", label);

		webDriver.findElement(By.xpath(path)).click();

		sleep(1000);
	}

	private void input(String type, String label, String text) {
		String path = jsonLocators.getJSONObject(type).getString("xpath");

		path = path.replace("{access_name}", label);

		webDriver.findElement(By.xpath(path)).clear();
		webDriver.findElement(By.xpath(path)).sendKeys(text);
	}

	private void sleep(long milliseconds) {
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
