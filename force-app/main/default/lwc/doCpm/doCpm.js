import { LightningElement, wire, track } from 'lwc';
import getTodos from '@salesforce/apex/TodoController.getTodos';
import markComplete from '@salesforce/apex/TodoController.markComplete';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DoCpm extends LightningElement {
    @track todos = [];
    wiredResult;

    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Completed', fieldName: 'Completed__c', type: 'boolean' },
        {
            type: 'button',
            typeAttributes: {
                label: 'Complete',
                name: 'complete',
                variant: 'brand',
                disabled: { fieldName: 'Completed__c' }
            }
        }
    ];

    @wire(getTodos)
    wiredTodos(result) {
        this.wiredResult = result;
        const { data, error } = result;
        if (data) {
            this.todos = data;
        } else if (error) {
            this.showToast('Error', this.normalizeError(error), 'error');
        }
    }

    get hasData() {
        return this.todos && this.todos.length > 0;
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'complete') {
            this.completeRow(row);
        }
    }

    async completeRow(row) {
        try {
            await markComplete({ recordId: row.Id });
            this.showToast('Success', 'Marked as complete', 'success');
            await refreshApex(this.wiredResult);
        } catch (e) {
            this.showToast('Error', this.normalizeError(e), 'error');
        }
    }

    // Support clicking on checkbox in the table if user toggles it
    async handleCellChange(event) {
        const drafts = event.detail.draftValues;
        if (!drafts || drafts.length === 0) return;
        const draft = drafts[0];
        // If user tries to set Completed__c true, call complete
        if (draft.Completed__c === true && draft.Id) {
            try {
                await markComplete({ recordId: draft.Id });
                this.showToast('Success', 'Marked as complete', 'success');
                await refreshApex(this.wiredResult);
            } catch (e) {
                this.showToast('Error', this.normalizeError(e), 'error');
            }
        } else {
            // Disallow un-completing in this simple UI
            this.showToast('Info', 'Un-completing is not supported in this component', 'info');
            await refreshApex(this.wiredResult);
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }

    normalizeError(error) {
        let message = 'Unknown error';
        if (Array.isArray(error?.body)) {
            message = error.body.map(e => e.message).join(', ');
        } else if (typeof error?.body?.message === 'string') {
            message = error.body.message;
        } else if (typeof error === 'string') {
            message = error;
        }
        return message;
    }
}