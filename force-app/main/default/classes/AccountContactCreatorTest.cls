@IsTest
public with sharing class AccountContactCreatorTest {
    @IsTest
    public static void testSuccessPost(){
        String s = '{ "Name":"LWC Kaanam", "Type":"Customer - Direct", "Phone":"+61470688711", "Fax":null, "AccountNumber":null, "Industry":"Apparel", "AnnualRevenue":null, "NumberOfEmployees":null, "Ownership":"Public", "Description":"Test Description", "Rating":"Warm", "contacts":[{ "LastName":"Young", "FirstName":"Andy", "Salutation":"Mr", "Phone":"(785) 241-6200", "MobilePhone":"(785) 265-5350", "Email":"a_young@dickenson.com", "Title":"SVP, Operations", "Department":"Internal Operations", "Description":"Test Contact"},{ "LastName":"Young", "FirstName":"Not Andy", "Salutation":"Mr", "Phone":"(785) 241-6200", "MobilePhone":"(785) 265-5350", "Email":"not_young@dickenson.com", "Title":"SVP, Operations", "Department":"External Operations", "Description":"Test Contact"} ]}';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/account/contact/v1/'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json'); 
        req.requestBody = Blob.valueOf(s);

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        AccountContactCreator.createAccountAndContact();
        res = RestContext.response; 

        Blob actual = res.responseBody;
        Test.stopTest();

        Account[] accts = [select Id from Account];
        Contact[] contacts = [select Id from Contact];

        System.assertEquals(1, accts.size());
        System.assertEquals(2, contacts.size());

        System.assertEquals(actual, null);
        System.assertEquals(201,res.statusCode);
    }

    @IsTest
    public static void testDMLException(){
        String s = '{ "Type":"Customer - Direct", "Phone":"+61470688711", "Fax":null, "AccountNumber":null, "Industry":"Apparel", "AnnualRevenue":null, "NumberOfEmployees":null, "Ownership":"Public", "Description":"Test Description", "Rating":"Warm", "contacts":[{ "LastName":"Young", "FirstName":"Andy", "Salutation":"Mr", "Phone":"(785) 241-6200", "MobilePhone":"(785) 265-5350", "Email":"a_young@dickenson.com", "Title":"SVP, Operations", "Department":"Internal Operations", "Description":"Test Contact"},{ "LastName":"Young", "FirstName":"Not Andy", "Salutation":"Mr", "Phone":"(785) 241-6200", "MobilePhone":"(785) 265-5350", "Email":"not_young@dickenson.com", "Title":"SVP, Operations", "Department":"External Operations", "Description":"Test Contact"} ]}';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/account/contact/v1/'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json'); 
        req.requestBody = Blob.valueOf(s);

        RestContext.request = req;
        RestContext.response = res;
       
        Test.startTest();
        AccountContactCreator.createAccountAndContact();
        res = RestContext.response; 
        Test.stopTest();

        Account[] accts = [select Id from Account];
        Contact[] contacts = [select Id from Contact];

        System.assertEquals(0, accts.size());
        System.assertEquals(0, contacts.size());


        String actual = res.responseBody.toString(); 
        System.assertEquals(actual, '{error: Required fields are missing: [Name]}');
        System.assertEquals(500,res.statusCode); 
    }

    @IsTest
    public static void testGenericException(){
        String s = '{ame": "LWC Kaanam", "Type":"Customer - Direct", "Phone":"+61470688711", "Fax":null, "AccountNumber":null, "Industry":"Apparel", "AnnualRevenue":null, "NumberOfEmployees":null, "Ownership":"Public", "Description":"Test Description", "Rating":"Warm", "contacts":[{ "LastName":"Young", "FirstName":"Andy", "Salutation":"Mr", "Phone":"(785) 241-6200", "MobilePhone":"(785) 265-5350", "Email":"a_young@dickenson.com", "Title":"SVP, Operations", "Department":"Internal Operations", "Description":"Test Contact"},{ "LastName":"Young toooooooooooooooooooooooooooooooooooooooooooooooooo looooooooooooooooooooooooooooooooooooooooooooooooooooooooooonnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggggggggggggggggggggggggggggggggg", "FirstName":"Not Andy", "Salutation":"Mr", "Phone":"(785) 241-6200", "MobilePhone":"(785) 265-5350", "Email":"not_young@dickenson.com", "Title":"SVP, Operations", "Department":"External Operations", "Description":"Test Contact"} ]}';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/account/contact/v1/'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json'); 
        req.requestBody = Blob.valueOf(s);

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        AccountContactCreator.createAccountAndContact();
        res = RestContext.response; 
        Test.stopTest();

        Account[] accts = [select Id from Account];
        Contact[] contacts = [select Id from Contact];

        System.assertEquals(0, accts.size());
        System.assertEquals(0, contacts.size());

        String actual = res.responseBody.toString();
        System.assertEquals(actual, '{error: Unexpected character (\'a\' (code 97)): was expecting double-quote to start field name at [line:1, column:3]}');
        System.assertEquals(400,res.statusCode); 
    }
}