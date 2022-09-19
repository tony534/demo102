public with sharing class ContactTriggerHandler extends TriggerHandler{
    // before insert event.
    public override void afterInsert() {
        ContactTriggerHelper.setupPrimaryContact(Trigger.new);
    }
}

