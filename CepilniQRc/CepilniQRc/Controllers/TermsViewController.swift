//
//  TermsViewController.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 02/08/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UIAdaptivePresentationControllerDelegate {

	@IBOutlet var closeBarButton: UIBarButtonItem!
	@IBOutlet var acceptButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		isModalInPresentation = !AppSettings.shared.termsAccepted
		navigationController?.presentationController?.delegate = self

		if !AppSettings.shared.termsAccepted {
			navigationItem.rightBarButtonItem = nil
		} else {
			acceptButton.removeFromSuperview()
		}
	}

	func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
		return false
	}

	@IBAction func acceptTapped(_ sender: UIButton) {
		AppSettings.shared.termsAccepted = true
	}
}
