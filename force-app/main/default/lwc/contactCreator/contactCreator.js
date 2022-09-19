/**
 * Created by gw831 on 16/09/2022.
 */

import {LightningElement, api} from 'lwc';
import saveContactAction from '@salesforce/apex/ContactController.saveContact';

export default class ContactCreator extends LightningElement {
    @api recordId;

    async handleNewContact(event){
        event.preventDefault();

        let conObj = {};
        [...this.template.querySelectorAll('lightning-input-field')].forEach(item => {
            conObj[item.dataset.name] = item.value;
        });

        console.log("conObj", conObj);

        try{
            await saveContactAction({acctId: this.recordId, conObj});
        }catch(ex){
            console.log(ex);
        }

    }

}