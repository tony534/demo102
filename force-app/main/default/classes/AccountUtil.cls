/**
 * Help class to provide contact utility methods.
 */
public with sharing class AccountUtil {
    /**
     * @param accountMap - map for single account from inbound payload.
     * @return SObject account
     */
    public static Account getAccount(Map<String, Object> accountMap) {
        Account acct = new Account();
        for(String key: accountMap.keySet()){
            if( key != 'contacts'){
                acct.put(key, accountMap.get(key));
            }
        }
        return acct;
    }
}