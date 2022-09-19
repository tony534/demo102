@IsTest
public with sharing class ContactTriggerHandlerTest {
    @TestSetup
    public static void setup(){
        Account acct1 = new Account(name='acct1');
        insert acct1;
    }

    @IsTest
    public static void testPrimaryContact(){
        Account[] accts = [select id,  Primary_Contact__c from Account];
        Contact conObj1 = new Contact(Lastname = 'con1', Primary__c = true, accountId = accts[0].Id);
        insert conObj1; 

        accts = [select id,  Primary_Contact__c from Account];
        system.assertEquals(conObj1.Id, accts[0].Primary_Contact__c);
    }
}
