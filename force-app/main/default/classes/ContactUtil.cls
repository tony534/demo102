/**
 * Help class to provide contact utility methods.
 */
public with sharing class ContactUtil {
    /**
     * @param contactMap - map for single contact from inbound payload.
     * @return SObject contacts
     */
    public static Contact getContact(Map<String, Object> contactMap) {
        if(contactMap == null){ return null; }
        
        Contact conObj = new Contact();
        for(String key : contactMap.keySet()){
            if(contactMap.get(key) != null){
                conObj.put(key, contactMap.get(key));
            }
        }
        return conObj;
        
    }

    /**
     * @param contactMap - map for mulitple contact from inbound payload.
     * @return list of SObject Contacts
     */
    public static Contact[] getContacts(Map<String, Object> payloadMap){
        List<Object> objs = (List<Object>) payloadMap.get(Constants.PAYLOAD_KEY_CONTACTS);
        List<Contact> contacts = new List<Contact>();
        if(objs != null){
            for(Object obj : objs){
                Map<String, Object> contactMap = (Map<String, Object>) obj;
                Contact conObj = getContact(contactMap);
                if(conObj != null){
                    contacts.add(conObj);
                }
            }
        }
        return contacts;
    }
}