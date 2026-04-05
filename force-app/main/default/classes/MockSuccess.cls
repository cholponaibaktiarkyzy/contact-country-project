@isTest
public class MockSuccess implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"country":[{"country_id":"US","probability":0.9}]}');
        return res;
    }
}