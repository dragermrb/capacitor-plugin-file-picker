import { WebPlugin } from '@capacitor/core';
import type { FilePickerOptions, FilePickerPlugin, FilePickerResults } from './definitions';
export declare class FilePickerWeb extends WebPlugin implements FilePickerPlugin {
    pick(options: FilePickerOptions): Promise<FilePickerResults>;
}
