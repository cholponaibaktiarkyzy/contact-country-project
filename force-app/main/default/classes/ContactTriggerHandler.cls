public with sharing class ContactTriggerHandler {

    public static void handleAfterInsert(List<Contact> contacts) {
        List<Id> contactIds = new List<Id>();

        for (Contact c : contacts) {
            if (!String.isBlank(c.FirstName)) {
                contactIds.add(c.Id);
            }
        }

        if (!contactIds.isEmpty()) {
            fetchCountry(contactIds);
        }
    }

    @future(callout=true)
    public static void fetchCountry(List<Id> contactIds) {

        List<Contact> contacts = [SELECT Id, FirstName FROM Contact WHERE Id IN :contactIds];
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Contact c : contacts) {
            try {
                Http http = new Http();
                HttpRequest req = new HttpRequest();

                String endpoint = 'https://api.nationalize.io/?name=' + EncodingUtil.urlEncode(c.FirstName, 'UTF-8');
                req.setEndpoint(endpoint);
                req.setMethod('GET');

                HttpResponse res = http.send(req);

                if (res.getStatusCode() == 200) {
                    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                    List<Object> countries = (List<Object>) result.get('country');

                    if (!countries.isEmpty()) {
                        Map<String, Object> firstCountry = (Map<String, Object>) countries[0];
                        String countryId = (String) firstCountry.get('country_id');

                        c.Predicted_Country__c = countryId;
                        contactsToUpdate.add(c);
                    }
                }

            } catch (Exception e) {
                System.debug('Error: ' + e.getMessage());
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}