import { WebPlugin } from '@capacitor/core';

import type {
  FilePickerOptions,
  FilePickerPlugin,
  FilePickerResults,
} from './definitions';

export class FilePickerWeb extends WebPlugin implements FilePickerPlugin {
  async pick(options: FilePickerOptions): Promise<FilePickerResults> {
    console.log('pick', options);

    throw this.unimplemented('Not implemented on web.');
  }
}
