import Foundation
import Capacitor
import CoreServices

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FilePickerPlugin)
public class FilePickerPlugin: CAPPlugin {
    var savedCall: CAPPluginCall? = nil

    @objc func pick(_ call: CAPPluginCall) {
        savedCall = call

        let multiple = call.getBool("multiple") ?? false
        let mimes = call.getArray("mimes", String.self) ?? ["*"]
        var extUTIs: [String] = []

        for mimeType in mimes
        {
            var extUTI:CFString?

            switch mimeType {
				case "audio/*":
					extUTI = kUTTypeAudio
				case "image/*":
					extUTI = kUTTypeImage
				case "text/*":
					extUTI = kUTTypeText
				case "video/*":
					extUTI = kUTTypeVideo
				default:
                    extUTI = kUTTypeData

                    if mimeType.range(of: "*") == nil {
                        let utiUnmanaged = UTTypeCreatePreferredIdentifierForTag(
                            kUTTagClassMIMEType,
                            mimeType as CFString,
                            nil
                        )

                        if let uti = (utiUnmanaged?.takeRetainedValue() as String?) {
                            if !uti.hasPrefix("dyn.") {
                                extUTI = uti as CFString
                            }
                        }
                    }
					break
			}

            extUTIs.append(extUTI! as String)
        }

        DispatchQueue.main.async {
            let types: [String] = extUTIs
            let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
            documentPicker.delegate = self
            documentPicker.modalPresentationStyle = .formSheet
            documentPicker.allowsMultipleSelection = multiple

            self.bridge!.viewController!.present(documentPicker, animated: true)
        }
    }
}

extension FilePickerPlugin: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        var files = [JSObject]()

        for url in urls
        {
            var file = JSObject()
            
            file["path"] = url.absoluteString
            file["webPath"] = self.bridge?.portablePath(fromLocalURL: url)?.absoluteString
            file["name"] = url.lastPathComponent
            file["extension"] = url.pathExtension
            
            files.append(file);
        }

        savedCall!.resolve([
            "files": files
        ])
    }

    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        savedCall!.reject("canceled")
    }
}
