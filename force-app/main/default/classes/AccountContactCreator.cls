/**
 *  API layer for external clients. 
 */
@RestResource(urlMapping='/account/contact/v1/*')
global with sharing class AccountContactCreator {
    /**
     *  extract account and contacts from inbound payload and save them to Salesforce database.
     */
    @HttpPost
    global static void  createAccountAndContact(){
        String reqBody = RestContext.request.requestBody.toString();
        new AccountContactService().createAccountContactFromPayload(reqBody);
    }

}