# capacitor-plugin-file-picker

Capacitor plugin to pick files

## Install

```bash
npm install @whiteguru/capacitor-plugin-file-picker
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
pick(options: FilePickerOptions) => any
```

| Param         | Type                                                            |
| ------------- | --------------------------------------------------------------- |
| **`options`** | <code><a href="#filepickeroptions">FilePickerOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### Interfaces


#### FilePickerOptions

| Prop           | Type                 | Description           |
| -------------- | -------------------- | --------------------- |
| **`multiple`** | <code>boolean</code> | Select multiple Files |
| **`mimes`**    | <code>{}</code>      | Mimes to select       |


#### FilePickerResults

| Prop        | Type            |
| ----------- | --------------- |
| **`files`** | <code>{}</code> |


#### FilePickerResult

| Prop            | Type                | Description                                                                                                       |
| --------------- | ------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **`path`**      | <code>string</code> | File Path                                                                                                         |
| **`webPath`**   | <code>string</code> | webPath returns a path that can be used to set the src attribute of an image for efficient loading and rendering. |
| **`name`**      | <code>string</code> | File Name                                                                                                         |
| **`extension`** | <code>string</code> | File Extensions                                                                                                   |

</docgen-api>
