//
//  EUGreenCertificateGeneralSection.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

struct EUGreenCertificateGeneralSection: CertificateSectionDataSource {

	var title: String {
		NSLocalizedString("General data", comment: "")
	}

	var numberOfRows: Int {
		6
	}

	private let greenCertificate: EUGreenCertificate
	private let reuseIdentifier: String

	private let dateFormatter = DateFormatter()

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier

		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = NSLocalizedString("Schema version", comment: "")
			cell.detailTextLabel?.text = greenCertificate.version
		case 1:
			cell.textLabel?.text = NSLocalizedString("Key ID Data", comment: "")
			cell.detailTextLabel?.text = greenCertificate.keyIdData.hexEncodedString()
		case 2:
			cell.textLabel?.text = NSLocalizedString("Issuer Country", comment: "")
			cell.detailTextLabel?.text = greenCertificate.issuerCountry
		case 3:
			cell.textLabel?.text = NSLocalizedString("Date of birth", comment: "")
			cell.detailTextLabel?.text = greenCertificate.dateOfBirth
		case 4:
			cell.textLabel?.text = NSLocalizedString("issueDate (?)", comment: "")
			cell.detailTextLabel?.text = dateFormatter.string(from: greenCertificate.issueDate)
		case 5:
			cell.textLabel?.text = NSLocalizedString("expirationDate (?)", comment: "")
			cell.detailTextLabel?.text = dateFormatter.string(from: greenCertificate.expirationDate)
		default:
			break
		}

		return cell
	}
}

fileprivate extension Data {
	func hexEncodedString() -> String {
		return map {
			String(format: "%02hhx", $0)
		}.joined(separator: " ")
	}
}
