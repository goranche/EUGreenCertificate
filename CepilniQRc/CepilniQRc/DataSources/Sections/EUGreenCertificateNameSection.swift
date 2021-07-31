//
//  EUGreenCertificateNameSection.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

struct EUGreenCertificateNameSection: CertificateSectionDataSource {

	var title: String {
		NSLocalizedString("Name", comment: "")
	}

	var numberOfRows: Int {
		6
	}

	private let greenCertificate: EUGreenCertificate
	private let reuseIdentifier: String

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = NSLocalizedString("Forename(s)", comment: "")
			cell.detailTextLabel?.text = greenCertificate.name.foreName
		case 1:
			cell.textLabel?.text = NSLocalizedString("Standardised forename(s)", comment: "")
			cell.detailTextLabel?.text = greenCertificate.name.foreNameStandard
		case 2:
			cell.textLabel?.text = NSLocalizedString("Surname(s)", comment: "")
			cell.detailTextLabel?.text = greenCertificate.name.surName
		case 3:
			cell.textLabel?.text = NSLocalizedString("Standardised surname(s)", comment: "")
			cell.detailTextLabel?.text = greenCertificate.name.surNameStandard
		case 4:
			cell.textLabel?.text = NSLocalizedString("Full name", comment: "")
			cell.detailTextLabel?.text = greenCertificate.name.fullName
		case 5:
			cell.textLabel?.text = NSLocalizedString("Name in passport", comment: "")
			cell.detailTextLabel?.text = greenCertificate.name.standardName
		default:
			break
		}

		return cell
	}
}
