package steps.collections;

import cucumber.api.PendingException;
import cucumber.api.java8.En;
import entities.collections.PaymentMethod;
import pages.DashboardPage;
import pages.collections.MiscellaneousPage;
import pages.collections.PropertyTaxPage;
import steps.BaseSteps;
import utils.ExcelReader;


/**
 * Created by soumyaghosh on 01/12/16.
 */
public class MiscellaneousSteps extends BaseSteps implements En {
    public MiscellaneousSteps() {
        And("^he enters Miscellaneous header$", () -> {
            pageStore.get((MiscellaneousPage.class)).enterMiscellaneousDetails();
        });
        And("^he pays using (\\w+)$", (String paymentMode) -> {
            PaymentMethod paymentmethod = new ExcelReader(collectionsTestDataFileName).getPaymentMethodDetails(paymentMode);
            pageStore.get(MiscellaneousPage.class).enterPaymentDetails(paymentmethod, paymentMode);
        });
        And("^he chooses to act upon the above receipt in drafts$", () -> {
           pageStore.get(MiscellaneousPage.class).openAboveReceipt("official_drafts");
        });
        And("^he submit all collections$", () -> {
          String message =  pageStore.get(MiscellaneousPage.class).submitAllCollections();
          scenarioContext.setActualMessage(message);
        });
        And("^user closes the acknowledgement$", () -> {
           pageStore.get(MiscellaneousPage.class).close();
        });
        And("^he chooses to act upon the above receipt in inbox$", () -> {
            pageStore.get(MiscellaneousPage.class).openAboveReceipt("official_inbox");
        });
        And("^he approves all collections$", () -> {
           String message = pageStore.get(MiscellaneousPage.class).approveAllCollections();
           scenarioContext.setActualMessage(message);
        });
        And("^he chooses to search receipts$", () -> {
           pageStore.get(DashboardPage.class).choosesToSearchReceipt();
        });
        And("^he search for required receipt$", () -> {
            pageStore.get(MiscellaneousPage.class).searchRequiredReceipt();
        });
        And("^he selects the required receipt$", () -> {
            pageStore.get(MiscellaneousPage.class).selectRequiredReceipt();
        });
        And("^he cancel the receipt$", () -> {
           String message = pageStore.get(MiscellaneousPage.class).cancelReceipt();
           scenarioContext.setActualMessage(message);
        });
        And("^he chooses to bank remittance$", () -> {
           pageStore.get(DashboardPage.class).chooseToBankRemittance();
        });
        And("^he select the required file with bank details$", () -> {
           pageStore.get(MiscellaneousPage.class).enterBankDetails();

           String actualMessage = pageStore.get(MiscellaneousPage.class).successMessageOfRemittance();
           scenarioContext.setActualMessage(actualMessage);
        });
    }
}