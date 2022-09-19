public with sharing class ContactController {
    @AuraEnabled
    public static void saveContact(String acctId, Contact conObj){
        system.debug('conObj = '+conObj);
        conObj.AccountId = acctId;
        insert conObj;
        if(conObj.Primary__c){
            update new Account(Id=acctId, Primary_Contact__c = conObj.Id);
        }
        system.debug('contactId = '+conObj.Id);
    }
}