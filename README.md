# capacitor-plugin-file-picker

Capacitor plugin to pick files

## Install

```bash
npm install @whiteguru/capacitor-plugin-file-picker
npx cap sync
```

### Capacitor 4.x

```bash
npm install @whiteguru/capacitor-plugin-file-picker@4.0.1
npx cap sync
```


### Capacitor 3.x

```bash
npm install @whiteguru/capacitor-plugin-file-picker@3.0.1
npx cap sync
```

## API

<docgen-index>

* [`pick(...)`](#pick)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### pick(...)

```typescript
pick(options: FilePickerOptions) => Promise<FilePickerResults>
```

| Param         | Type                                                            |
| ------------- | --------------------------------------------------------------- |
| **`options`** | <code><a href="#filepickeroptions">FilePickerOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#filepickerresults">FilePickerResults</a>&gt;</code>

--------------------


### Interfaces


#### FilePickerResults

| Prop        | Type                            |
| ----------- | ------------------------------- |
| **`files`** | <code>FilePickerResult[]</code> |


#### FilePickerResult

| Prop            | Type                | Description                                                                                                       |
| --------------- | ------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **`path`**      | <code>string</code> | File Path                                                                                                         |
| **`webPath`**   | <code>string</code> | webPath returns a path that can be used to set the src attribute of an image for efficient loading and rendering. |
| **`name`**      | <code>string</code> | File Name                                                                                                         |
| **`extension`** | <code>string</code> | File Extensions                                                                                                   |


#### FilePickerOptions

| Prop           | Type                  | Description           |
| -------------- | --------------------- | --------------------- |
| **`multiple`** | <code>boolean</code>  | Select multiple Files |
| **`mimes`**    | <code>string[]</code> | Mimes to select       |

</docgen-api>
