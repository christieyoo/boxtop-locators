package me.khyen;

import cucumber.api.java.en.When;
import cucumber.api.java.en.Given;
import cucumber.api.java.Before;
import cucumber.api.java.After;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class StepDefinitions {

	@Before
	public void setup() throws InterruptedException {
		System.setProperty("webdriver.chrome.driver", "build/resources/test/chrome/linux64/chromedriver");

		webDriver = new ChromeDriver();
	}

	@After
	public void teardown() {
		webDriver.quit();
	}

	@When("^I run this correctly$")
	public void I_run_this_correctly() {
		System.out.println("test");
	}

	@Given("^Something here$")
	public void Something_here() throws InterruptedException {
		System.out.println("something here");
	}

	protected WebDriver webDriver;

}
