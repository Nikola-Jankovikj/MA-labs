//
//  CameraViewController.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 28.12.24.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate: CameraViewControllerDelegate?
    private let imagePicker = UIImagePickerController()
    private var isPickerPresented = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkCameraPermission { [weak self] authorized in
            guard let self = self else { return }
            
            if authorized {
                self.presentCamera()
            } else {
                self.showPermissionAlert()
            }
        }
    }

    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }

    private func presentCamera() {
        if !isPickerPresented {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                present(imagePicker, animated: true, completion: nil)
                isPickerPresented = true
            } else {
                showCameraUnavailableAlert()
            }
        }
    }

    private func showPermissionAlert() {
        let alert = UIAlertController(title: "Camera Permission Needed",
                                       message: "Please enable camera access in Settings to take photos.",
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }

    private func showCameraUnavailableAlert() {
        let alert = UIAlertController(title: "Error", message: "Camera is not available on this device.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let capturedImage = info[.originalImage] as? UIImage {
            delegate?.didCaptureImage(capturedImage)
        }
        dismiss(animated: true, completion: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        })
    }
}
