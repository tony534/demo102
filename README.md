## Assumptions:
1. one account has at most one primary contact which can be selected during the lwc contact selection.
2. primary contact is required during the order creation.

## note
a new customer field Primary_Contact__c was created to link the account and corresponding primary contact.

Contact and Order creators can be found from Account detail page.

The endpiont for rest api is /services/apexrest/account/contact/v1/