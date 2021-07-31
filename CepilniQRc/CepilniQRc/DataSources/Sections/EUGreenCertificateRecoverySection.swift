//
//  EUGreenCertificateRecoverySection.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

struct EUGreenCertificateRecoverySection: CertificateSectionDataSource {

	var title: String {
		NSLocalizedString("Recovery data", comment: "")
	}

	var numberOfRows: Int {
		7
	}

	private let greenCertificate: EUGreenCertificate
	private let reuseIdentifier: String

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		guard let recovery = greenCertificate.recovery else {
			return cell
		}

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = NSLocalizedString("Disease or agent from which recovered", comment: "")
			cell.detailTextLabel?.text = recovery.tg
		case 1:
			cell.textLabel?.text = NSLocalizedString("Date of holder’s first positive test", comment: "")
			cell.detailTextLabel?.text = recovery.fr
		case 2:
			cell.textLabel?.text = NSLocalizedString("State or third country of testing", comment: "")
			cell.detailTextLabel?.text = recovery.co
		case 3:
			cell.textLabel?.text = NSLocalizedString("Certificate issuer", comment: "")
			cell.detailTextLabel?.text = recovery.is
		case 4:
			cell.textLabel?.text = NSLocalizedString("Certificate valid from", comment: "")
			cell.detailTextLabel?.text = recovery.df
		case 5:
			cell.textLabel?.text = NSLocalizedString("Certificate valid until", comment: "")
			cell.detailTextLabel?.text = recovery.du
		case 6:
			cell.textLabel?.text = NSLocalizedString("Unique certificate identifier", comment: "")
			cell.detailTextLabel?.text = recovery.ci
		default:
			break
		}

		return cell
	}
}
