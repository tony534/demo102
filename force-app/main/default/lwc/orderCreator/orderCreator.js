import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OrderCreator extends LightningElement {
   @api recordId = '0015g00000nwdgiAAA';  
   
   handleOrderCreated(){
    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Success',
            message: 'Order created',
            variant: 'success',
        }),
    );

    [...this.template.querySelectorAll(".editable")].forEach(item => item.reset());
   }
}