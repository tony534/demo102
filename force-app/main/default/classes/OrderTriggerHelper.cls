public with sharing class OrderTriggerHelper {
    /**
        @param orderlist - incoming order list for trigger
        check the CustomerAuthorizedById is a primary contact
     */
    public static void checkCustomerAuthorizedByContact(List<Order> orderList){
        List<Id> contactIds = new List<Id>();
        for(Order o : orderList) {
            if(o.CustomerAuthorizedById == null){
                o.addError('Customer AuthorizedBy missing.');
            }else{
                contactIds.add(o.CustomerAuthorizedById);
            }
        }

        Map<Id, Contact> contactMap = new Map<Id, Contact>([select Id, Primary__c from Contact where id in :contactIds]);
        for(Order o : orderList) {
            if(contactMap.get(o.CustomerAuthorizedById) != null ){
                Contact conObj = contactMap.get(o.CustomerAuthorizedById);
                if(!conObj.Primary__c){
                    o.addError('primary contact required');
                }
            }else{
                o.addError('primary contact missing');
            }
        }

    }

    /**
     @param orderlist - incoming order list for trigger
     assign the account primary contact to the order.
     */
    public static void checkCustomerAuthorizedByAccount(List<Order> orderList){
        List<Id> acctIds = new List<Id>();
        for(Order o : orderList) {
            acctIds.add(o.AccountId);
        }

        Map<Id, Account> acctMap = new Map<Id, Account>([select Id, Primary_Contact__c  from Account where id in :acctIds]);
        for(Order o : orderList) {
            Account acct = acctMap.get(o.AccountId);
            if(acct != null  && acct.Primary_Contact__c != null){
                o.CustomerAuthorizedById = acct.Primary_Contact__c;
            }else{
                o.addError('Account: primary contact missing');
            }
        }
    }
}

