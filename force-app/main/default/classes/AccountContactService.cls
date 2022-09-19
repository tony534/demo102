/**
 *  serivce class to handle the Account and Contact related business logic
 */
public with sharing class AccountContactService {
    /**
     *  extract the account and contacts and save them into salesforce database.
     * 
     */
    public void createAccountContactFromPayload(String payload){
       try{
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(payload); 
            Account acct = AccountUtil.getAccount(m);
            insert acct;
            List<Contact> conObjs = ContactUtil.getContacts(m);
            for(Contact conObj  : conObjs ){
                conObj.AccountId = acct.Id;
            }
            insert conObjs; 
            RestResponse response = RestContext.response;
            response.addHeader('Content-Type', 'application/json');
            response.statusCode = 201;
       }catch(System.DmlException ex){
            RestResponse response = RestContext.response;
            response.addHeader('Content-Type', 'application/json');
            response.statusCode = 500;
            response.responseBody = Blob.valueOf('{error: '+ ex.getDmlMessage(0) +'}');
      }catch(Exception ex){
            RestResponse response = RestContext.response;
            response.addHeader('Content-Type', 'application/json');
            response.statusCode = 400;
            response.responseBody = Blob.valueOf('{error: '+ex.getMessage()+'}');
       }
    }
}