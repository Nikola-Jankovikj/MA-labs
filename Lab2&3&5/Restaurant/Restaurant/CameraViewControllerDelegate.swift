//
//  CameraViewControllerDelegate.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 28.12.24.
//

import Foundation
import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
}
