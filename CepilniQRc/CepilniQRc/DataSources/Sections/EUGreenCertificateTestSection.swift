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

	private let dateFormatter = DateFormatter()

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier

		dateFormatter.timeStyle = .short
		dateFormatter.dateStyle = .medium
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		guard let test = greenCertificate.test else {
			return cell
		}

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = NSLocalizedString("Disease or agent targeted", comment: "")
			cell.detailTextLabel?.text = test.diseaseAgent.display
		case 1:
			cell.textLabel?.text = NSLocalizedString("The type of test", comment: "")
			cell.detailTextLabel?.text = test.testType.display
		case 2:
			cell.textLabel?.text = NSLocalizedString("Test name", comment: "")
			cell.detailTextLabel?.text = test.testName ?? NSLocalizedString("<empty>", comment: "")
		case 3:
			cell.textLabel?.text = NSLocalizedString("Test device identifier", comment: "")
			cell.detailTextLabel?.text = test.testDeviceId ?? NSLocalizedString("<empty>", comment: "")
		case 4:
			cell.textLabel?.text = NSLocalizedString("Date and time of the test sample collection", comment: "")
			cell.detailTextLabel?.text = dateFormatter.string(from: test.sampleCollected)
		case 5:
			cell.textLabel?.text = NSLocalizedString("Result of the test", comment: "")
			cell.detailTextLabel?.text = test.testResult.display
		case 6:
			cell.textLabel?.text = NSLocalizedString("Testing centre or facility", comment: "")
			cell.detailTextLabel?.text = test.testCenter ?? NSLocalizedString("<empty>", comment: "")
		case 7:
			cell.textLabel?.text = NSLocalizedString("State or third country of testing", comment: "")
			cell.detailTextLabel?.text = test.countryOfTest.display
		case 8:
			cell.textLabel?.text = NSLocalizedString("Certificate issuer", comment: "")
			cell.detailTextLabel?.text = test.certificateIssuer
		case 9:
			cell.textLabel?.text = NSLocalizedString("Unique certificate identifier", comment: "")
			cell.detailTextLabel?.text = test.certificateId
		default:
			break
		}

		return cell
	}
}
