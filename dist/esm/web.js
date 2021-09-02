import { WebPlugin } from '@capacitor/core';
export class FilePickerWeb extends WebPlugin {
    async pick(options) {
        console.log('pick', options);
        throw this.unimplemented('Not implemented on web.');
    }
}
//# sourceMappingURL=web.js.map