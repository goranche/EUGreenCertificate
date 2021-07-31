//
//  ScannerViewController.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import AVFoundation
import EUGreenCertificate

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

	@IBOutlet var dataLabel: UILabel!
	@IBOutlet var infoLabel: UILabel!
	@IBOutlet var viewFinder: UIImageView!

	@IBOutlet var detailButton: UIButton!

	let captureSession = AVCaptureSession()
	var previewLayer: AVCaptureVideoPreviewLayer!

	var greenCertificate: EUGreenCertificate? = nil {
		didSet {
			DispatchQueue.main.async {
				self.detailButton.isEnabled = self.greenCertificate != nil

				guard let greenCertificate = self.greenCertificate else {
					self.dataLabel.text = nil
					self.viewFinder.tintColor = .systemGray
					return
				}

				self.dataLabel.text = "\(greenCertificate.name.fullName)\n\(greenCertificate.dateOfBirth)"
				self.viewFinder.tintColor = .systemPurple
			}
		}
	}
	var errorString: String? = nil {
		didSet {
			DispatchQueue.main.async {
				self.infoLabel.text = self.errorString
				guard let _ = self.errorString else {
					return
				}
				self.viewFinder.tintColor = .systemRed
			}
		}
	}

	override var prefersStatusBarHidden: Bool {
		true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		.portrait
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// NOTE: Not sure about the black color
		view.backgroundColor = .black

		AVCaptureDevice.requestAccess(for: AVMediaType.video) { [self] response in
			if response {
				guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
					fatalError("Couldn't find any video capture devices")
				}

				let videoInput: AVCaptureDeviceInput
				do {
					videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
				} catch {
					fatalError("An error occurred while creating input devices\n\(error.localizedDescription)")
				}

				guard captureSession.canAddInput(videoInput) else {
					fatalError("Capture session can't add video input")
				}

				captureSession.addInput(videoInput)

				let metadataOutput = AVCaptureMetadataOutput()

				guard captureSession.canAddOutput(metadataOutput) else {
					fatalError("Capture session can't add metadata output")
				}

				captureSession.addOutput(metadataOutput)

				metadataOutput.setMetadataObjectsDelegate(self, queue: .global(qos: .userInitiated))
				metadataOutput.metadataObjectTypes = [.qr]

				previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
				DispatchQueue.main.async {
					previewLayer.frame = view.layer.bounds
					previewLayer.videoGravity = .resizeAspectFill
					view.layer.insertSublayer(previewLayer, at: 0)
				}
			} else {
				fatalError("We need access...")
			}
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.setNavigationBarHidden(true, animated: true)

		greenCertificate = nil
		errorString = nil

		captureSession.startRunning()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		navigationController?.setNavigationBarHidden(false, animated: true)

		captureSession.stopRunning()
	}

	@IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
		greenCertificate = nil
		errorString = nil

		captureSession.startRunning()
	}

	@IBAction func unwindToScanner(_ segue: UIStoryboardSegue) {
		// Leaving empty, the function is here just so we can unwind in the storyboard
	}

	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		identifier == "showDetails" ? greenCertificate != nil : true
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let greenCertificate = greenCertificate, let destination = segue.destination as? DetailViewController else {
			return
		}
		destination.greenCertificate = greenCertificate
		captureSession.stopRunning()
	}

	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		captureSession.stopRunning()
		if let metadataObject = metadataObjects.first {
			guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
				captureSession.startRunning()
				errorString = NSLocalizedString("No readable metadata found.", comment: "")
				return
			}

			guard let stringValue = readableObject.stringValue else {
				captureSession.startRunning()
				errorString = NSLocalizedString("No string value found.", comment: "")
				return
			}

			AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

			switch EUGreenCertificate.decode(stringValue) {
			case .success(let qrCertificate):
				greenCertificate = qrCertificate
				captureSession.stopRunning()
			case .failure(let error):
				print("Error occurred: \(error.localizedDescription)")
				errorString = error.localizedDescription
				captureSession.startRunning()
			}
		}
	}
}
