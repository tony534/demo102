public with sharing class ContactTriggerHelper {
    public static void setupPrimaryContact(List<Contact> contactObjs){
        List<Id> accountIds = new List<Id>();
        for(Contact contactObj : contactObjs){
            if(contactObj.Primary__c){
                accountIds.add(contactObj.AccountId);     
            }
        }
        if(accountIds.size() != 0){
            Map<Id, Account> accountMap = new Map<Id, Account>([select id, Primary_Contact__c from Account where id in :accountIds]);
            Map<Id, Account> acctsTobeUpdated = new Map<Id, Account>();
            for(Contact contactObj : contactObjs){
                Account acct = accountMap.get(contactObj.accountId);
                if(acct != null ){
                    acct.Primary_Contact__c = contactObj.Id; 
                    acctsTobeUpdated.put( contactObj.accountId ,acct);
                }
            }
            if(acctsTobeUpdated.size() > 0){
                update acctsTobeUpdated.values();
            }
        } 
    }
}
