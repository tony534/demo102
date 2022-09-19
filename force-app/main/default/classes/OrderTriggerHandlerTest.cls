@IsTest
public with sharing class OrderTriggerHandlerTest {
    @TestSetup
    public static void setup(){
        Account acct = new Account(Name ='acct test1');
        Contact conObj1 = new Contact(lastname ='lastname test1');
        Contact conObj2 = new Contact(lastname ='lastname test2',  Primary__c = true);
        insert acct;
        conObj1.AccountId = acct.Id;
        conObj2.AccountId = acct.Id;
        insert new Contact[]{conObj1, conObj2};

        acct.Primary_Contact__c = conObj2.Id;
        update acct;

        Order o1 = new Order(Status='Draft', EffectiveDate =system.today() -1, Name='order 1', AccountId = acct.Id);   
        insert o1;
    }   


    @IsTest
    public static void testCreateOrderSuccess(){
       Order[] orders = [select id, CustomerAuthorizedById from order]; 
       Contact[] contacts = [select id from Contact where lastname='lastname test2'];
       system.assertEquals(1, orders.size());
       system.assertEquals(contacts[0].Id, orders[0].CustomerAuthorizedById);
    }

    @IsTest
    public static void testCreateOrderFailure1(){
        Account[] acct = [select id, Primary_Contact__c from Account];
        acct[0].Primary_Contact__c = null;
        update acct;
        Order o1 = new Order(Status='Draft', EffectiveDate =system.today() -2, Name='order 2', AccountId = acct[0].Id);   
        try{
            insert o1;
        }catch(DmlException ex){
            system.assertEquals('Account: primary contact missing', ex.getDmlMessage(0));
        }
        Order[] orders = [select id from order where Name = 'order 2'];
        system.assertEquals(0, orders.size());
    }

    @IsTest
    public static void testEditOrderSuccess(){
        Account[] acct = [select id, Primary_Contact__c from Account];
        acct[0].Primary_Contact__c = null;
        update acct;
        Order o1 = [select id from order][0];   
    
        o1.EffectiveDate = system.today() + 3;
        update o1;
        
        Order[] orders = [select id, EffectiveDate from order];
        system.assertEquals(System.today() + 3, orders[0].EffectiveDate);
    }

    @IsTest
    public static void testEditOrderFailure1(){
        Contact[] contacts = [select id from Contact where lastname='lastname test2'];
        contacts[0].Primary__c = false;
        update contacts;
        Order o1 = [select id from order][0];   
        o1.EffectiveDate = system.today() + 3;
        try{
            update o1;
        }catch(DmlException ex){
            system.assertEquals('primary contact required', ex.getDmlMessage(0));
        }
    }

    // @IsTest
    // public static void testEditOrderFailure2(){
    //     Order o1 = [select id, CustomerAuthorizedById from order][0];   
    //     o1.CustomerAuthorizedById = null;
    //     try{
    //         update o1;
    //     }catch(DmlException ex){
    //         system.assertEquals('Customer AuthorizedBy missing.', ex.getDmlMessage(0));
    //     }
    // }
}
