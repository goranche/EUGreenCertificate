//
//  EUGreenCertificateTestSection.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

struct EUGreenCertificateTestSection: CertificateSectionDataSource {

	var title: String {
		return NSLocalizedString("Test data", comment: "")
	}

	var numberOfRows: Int {
		10
	}

	private let greenCertificate: EUGreenCertificate
	private let reuseIdentifier: String

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		guard let test = greenCertificate.test else {
			return cell
		}

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = NSLocalizedString("Disease or agent targeted", comment: "")
			cell.detailTextLabel?.text = test.tg
		case 1:
			cell.textLabel?.text = NSLocalizedString("The type of test", comment: "")
			cell.detailTextLabel?.text = test.tt
		case 2:
			cell.textLabel?.text = NSLocalizedString("Test name", comment: "")
			cell.detailTextLabel?.text = test.nm ?? NSLocalizedString("<empty>", comment: "")
		case 3:
			cell.textLabel?.text = NSLocalizedString("Test device identifier", comment: "")
			cell.detailTextLabel?.text = test.ma ?? NSLocalizedString("<empty>", comment: "")
		case 4:
			cell.textLabel?.text = NSLocalizedString("Date and time of the test sample collection", comment: "")
			cell.detailTextLabel?.text = test.sc
		case 5:
			cell.textLabel?.text = NSLocalizedString("Result of the test", comment: "")
			cell.detailTextLabel?.text = test.tr
		case 6:
			cell.textLabel?.text = NSLocalizedString("Testing centre or facility", comment: "")
			cell.detailTextLabel?.text = test.tc ?? NSLocalizedString("<empty>", comment: "")
		case 7:
			cell.textLabel?.text = NSLocalizedString("State or third country of testing", comment: "")
			cell.detailTextLabel?.text = test.co
		case 8:
			cell.textLabel?.text = NSLocalizedString("Certificate issuer", comment: "")
			cell.detailTextLabel?.text = test.is
		case 9:
			cell.textLabel?.text = NSLocalizedString("Unique certificate identifier", comment: "")
			cell.detailTextLabel?.text = test.ci
		default:
			break
		}

		return cell
	}
}
