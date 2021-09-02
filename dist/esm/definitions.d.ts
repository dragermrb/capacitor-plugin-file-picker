export interface FilePickerPlugin {
    pick(options: FilePickerOptions): Promise<FilePickerResults>;
}
export interface FilePickerOptions {
    /**
     * Select multiple Files
     */
    multiple: boolean;
    /**
     * Mimes to select
     */
    mimes: string[];
}
export interface FilePickerResults {
    files: FilePickerResult[];
}
export interface FilePickerResult {
    /**
     * File Path
     */
    path: string;
    /**
     * webPath returns a path that can be used to set the src attribute of an image for efficient
     * loading and rendering.
     */
    webPath: string;
    /**
     * File Name
     */
    name: string;
    /**
     * File Extensions
     */
    extension: string;
}
