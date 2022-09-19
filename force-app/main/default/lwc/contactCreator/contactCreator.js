/**
 * Created by gw831 on 16/09/2022.
 */

import {LightningElement, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactCreator extends LightningElement {
    @api recordId;

    handleContactCreated(){
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Contact created',
                variant: 'success',
            }),
        );
    
        [...this.template.querySelectorAll(".editable")].forEach(item => item.reset());
    }

}