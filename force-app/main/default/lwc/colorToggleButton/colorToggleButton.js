import { LightningElement, api } from 'lwc';

export default class ColorToggleButton extends LightningElement {
    // Cho phép nhận nhãn từ App Builder/parent; mặc định "Đổi màu"
    @api label = 'Đổi màu';

    isActive = false;

    get buttonClass() {
        return `slds-button slds-button_neutral ${this.isActive ? 'active' : 'inactive'}`;
    }

    get computedLabel() {
        return this.label || 'Đổi màu';
    }

    handleClick() {
        this.isActive = !this.isActive;
    }
}
