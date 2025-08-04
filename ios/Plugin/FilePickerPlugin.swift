import Foundation
import Capacitor
import CoreServices
import AVFoundation

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

            if (mimeType.starts(with: "audio/*")) {
                extUTI = kUTTypeAudio
            } else if (mimeType.starts(with: "image/*")) {
                extUTI = kUTTypeImage
            } else if (mimeType.starts(with: "text/*")) {
                extUTI = kUTTypeText
            } else if (mimeType.starts(with: "video/*")) {
                extUTI = "public.movie" as CFString;
            } else {
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
            }

            extUTIs.append(extUTI! as String)
        }

        DispatchQueue.main.async {
            if (extUTIs.count == 1 && extUTIs.contains("public.movie")){
                let videoPicker = UIImagePickerController()
                videoPicker.delegate = self
                videoPicker.videoExportPreset = AVAssetExportPresetHighestQuality
                videoPicker.sourceType = .photoLibrary
                videoPicker.mediaTypes = [kUTTypeMovie as String]

                self.bridge!.viewController!.present(videoPicker, animated: true)
            } else {
                let documentPicker = UIDocumentPickerViewController(documentTypes: extUTIs, in: .import)
                documentPicker.delegate = self
                documentPicker.modalPresentationStyle = .formSheet
                documentPicker.allowsMultipleSelection = multiple

                self.bridge!.viewController!.present(documentPicker, animated: true)
            }
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

extension FilePickerPlugin: UIImagePickerControllerDelegate {
    public func imagePickerController(_ controller: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard
            let mediaUrl = info[.mediaURL] as? URL
        else {
            savedCall!.reject("Cannot get video URL")
            return
        }

        var url: URL;
        do{
            url = try saveTemporaryVideo(mediaUrl)
        } catch{
            savedCall!.reject("Cannot save video")
            return
        }

        var files = [JSObject]()
        var file = JSObject()

        file["path"] = url.absoluteString
        file["webPath"] = self.bridge?.portablePath(fromLocalURL: url)?.absoluteString
        file["name"] = url.lastPathComponent
        file["extension"] = url.pathExtension

        files.append(file);

        controller.dismiss(animated: true) {
            self.savedCall!.resolve([
                "files": files
            ])
        }
    }

    public func imagePickerControllerDidCancel(_ controller: UIImagePickerController) {
        controller.dismiss(animated: true) {
            self.savedCall!.reject("canceled")
        }
    }

    func saveTemporaryVideo(_ mediaUrl: URL) throws -> URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(mediaUrl.lastPathComponent)

        try FileManager.default.copyItem(at: mediaUrl, to: url)

        return url
    }
}

extension FilePickerPlugin: UINavigationControllerDelegate {

}
