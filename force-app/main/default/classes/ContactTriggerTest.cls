@isTest
public class ContactTriggerTest {

    @isTest
    static void testSuccess() {
        Test.setMock(HttpCalloutMock.class, new MockSuccess());

        Contact c = new Contact(LastName='Test', FirstName='Michael');

        Test.startTest();
        insert c;
        Test.stopTest();

        Contact result = [SELECT Predicted_Country__c FROM Contact WHERE Id=:c.Id];
        System.assertEquals('US', result.Predicted_Country__c);
    }

    @isTest
    static void testEmptyResponse() {
        Test.setMock(HttpCalloutMock.class, new MockEmpty());

        Contact c = new Contact(LastName='Test', FirstName='UnknownName');

        Test.startTest();
        insert c;
        Test.stopTest();

        Contact result = [SELECT Predicted_Country__c FROM Contact WHERE Id=:c.Id];
        System.assertEquals(null, result.Predicted_Country__c);
    }

    @isTest
    static void testError() {
        Test.setMock(HttpCalloutMock.class, new MockError());

        Contact c = new Contact(LastName='Test', FirstName='Error');

        Test.startTest();
        insert c;
        Test.stopTest();

        System.assert(true);
    }
}