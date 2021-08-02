//
//  TermsViewController.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 02/08/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UIAdaptivePresentationControllerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()

		isModalInPresentation = true
		navigationController?.presentationController?.delegate = self
	}

	func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
		return false
	}

	@IBAction func acceptTapped(_ sender: UIButton) {
		AppSettings.shared.termsAccepted = true
	}
}
