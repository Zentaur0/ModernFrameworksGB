import Foundation
import PhotosUI

final class ImagePickerController {
    
    // MARK: - Public Actions
    var onDismiss: ((ImagePickerController.Model) -> Void)?
    
    private lazy var imagePicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selection = .default
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        return controller
    }()
    
    func getPicker() -> PHPickerViewController {
        return imagePicker
    }
}

// MARK: - UIImagePickerControllerDelegate -
extension ImagePickerController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let providers = results.map(\.itemProvider)
        
        for provider in providers where provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async { [weak self] in
                    self?.onDismiss?(.init(image: image as? UIImage))
                }
            }
        }
    }
}

// MARK: - Model -
extension ImagePickerController {
    struct Model {
        let image: UIImage?
    }
}
