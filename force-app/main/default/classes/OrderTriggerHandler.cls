/**
    order handler class to add business logic to the trigger events
 */
public with sharing class OrderTriggerHandler extends TriggerHandler{
    // before update event
    public override void beforeUpdate() {
        OrderTriggerHelper.checkCustomerAuthorizedByContact(Trigger.new);
    }
    // before insert event.
    public override void beforeInsert() {
        OrderTriggerHelper.checkCustomerAuthorizedByAccount(Trigger.new);
    }
}
