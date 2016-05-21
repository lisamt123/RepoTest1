/**
 * This class has been generated to allow customization of Account creation for Chatter Answers Portal Users.
 * Chatter Answers requires that this class exist and implement ChatterAnswers.AccountCreator, renaming the class
 *   or removing the interface implementation is prohibited. */
public class ChatterAnswersRegistration implements ChatterAnswers.AccountCreator {
    public String createAccount(String firstname, String lastname, Id siteAdminId) {
         Account a = new Account(name = firstname + ' ' + lastname, ownerId = siteAdminId);
         		A.BillingCity = 'test';
        A.BillingCountry = 'USA';
        A.BillingPostalCode = '66212';
        A.BillingState = 'KS';
        A.BillingStreet = '1234';
        		A.ShippingCity = 'test';
        A.ShippingCountry = 'USA';
        A.ShippingPostalCode = '66212';
        A.ShippingState = 'KS';
        A.ShippingStreet = '1234';
         insert a;
         return a.Id;
    }
}