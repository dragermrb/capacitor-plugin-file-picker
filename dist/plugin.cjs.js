'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const FilePicker = core.registerPlugin('FilePicker', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.FilePickerWeb()),
});

class FilePickerWeb extends core.WebPlugin {
    async pick(options) {
        console.log('pick', options);
        throw this.unimplemented('Not implemented on web.');
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    FilePickerWeb: FilePickerWeb
});

exports.FilePicker = FilePicker;
//# sourceMappingURL=plugin.cjs.js.map
