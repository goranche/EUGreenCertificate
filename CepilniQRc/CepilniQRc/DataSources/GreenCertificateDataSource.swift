//
//  GreenCertificateDataSource.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

class GreenCertificateDataSource: NSObject, UITableViewDataSource {

	private enum CertificationType {
		case unknown
		case vaccination
		case test
		case recovery
	}

	private let greenCertificate: EUGreenCertificate
	private let reuseIdentifier: String

	private let dateFormatter = DateFormatter()

	private let certificationType: CertificationType

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier

		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none

		if let _ = greenCertificate.vaccination {
			certificationType = .vaccination
		} else if let _ = greenCertificate.test {
			certificationType = .test
		} else if let _ = greenCertificate.recovery {
			certificationType = .recovery
		} else {
			certificationType = .unknown
		}

	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return certificationType == .unknown ? 0 : 3
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 6
		case 1:
			return 4
		case 2:
			switch certificationType {
			case .vaccination:
				return 10
			case .test:
				return 10
			case .recovery:
				return 7
			default:
				return 0
			}
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "General data"
		case 1:
			return "Name"
		case 2:
			switch certificationType {
			case .vaccination:
				return "Vaccination data"
			case .test:
				return "Test data"
			case .recovery:
				return "Recovery data"
			default:
				return "Uknown certification"
			}
		default:
			return nil
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		switch indexPath.section {
		case 0:
			prepareGeneral(cell, at: indexPath.row)
		case 1:
			prepareName(cell, at: indexPath.row)
		case 2:
			switch certificationType {
			case .vaccination:
				prepareVaccination(cell, at: indexPath.row)
			case .test:
				prepareTest(cell, at: indexPath.row)
			case .recovery:
				prepareRecovery(cell, at: indexPath.row)
			default:
				break
			}
		default:
			break
		}

		return cell
	}

	private func prepareGeneral(_ cell: UITableViewCell, at row: Int) {
		switch row {
		case 0:
			cell.textLabel?.text = "Schema version"
			cell.detailTextLabel?.text = greenCertificate.version
		case 1:
			cell.textLabel?.text = "Key ID Data"
			cell.detailTextLabel?.text = greenCertificate.keyIdData.hexEncodedString()
		case 2:
			cell.textLabel?.text = "Issuer Country"
			cell.detailTextLabel?.text = greenCertificate.issuerCountry
		case 3:
			cell.textLabel?.text = "Date of birth"
			cell.detailTextLabel?.text = greenCertificate.dateOfBirth
		case 4:
			cell.textLabel?.text = "issueDate (?)"
			cell.detailTextLabel?.text = dateFormatter.string(from: greenCertificate.issueDate)
		case 5:
			cell.textLabel?.text = "expirationDate (?)"
			cell.detailTextLabel?.text = dateFormatter.string(from: greenCertificate.expirationDate)
		default:
			break
		}
	}

	private func prepareName(_ cell: UITableViewCell, at row: Int) {
		switch row {
		case 0:
			cell.textLabel?.text = "Forename(s)"
			cell.detailTextLabel?.text = greenCertificate.name.foreName
		case 1:
			cell.textLabel?.text = "Standardised forename(s)"
			cell.detailTextLabel?.text = greenCertificate.name.foreNameStandard
		case 2:
			cell.textLabel?.text = "Surname(s)"
			cell.detailTextLabel?.text = greenCertificate.name.surName
		case 3:
			cell.textLabel?.text = "Standardised surname(s)"
			cell.detailTextLabel?.text = greenCertificate.name.surNameStandard
		default:
			break
		}
	}

	private func prepareVaccination(_ cell: UITableViewCell, at row: Int) {
		guard certificationType == .vaccination, row < 10 else {
			return
		}
		switch row {
		case 0:
			cell.textLabel?.text = "ci"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.ci
		case 1:
			cell.textLabel?.text = "co"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.co
		case 2:
			cell.textLabel?.text = "dn"
			cell.detailTextLabel?.text = String(greenCertificate.vaccination?.dn ?? 0)
		case 3:
			cell.textLabel?.text = "dt"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.dt
		case 4:
			cell.textLabel?.text = "is"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.is
		case 5:
			cell.textLabel?.text = "ma"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.ma
		case 6:
			cell.textLabel?.text = "mp"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.mp
		case 7:
			cell.textLabel?.text = "sd"
			cell.detailTextLabel?.text = String(greenCertificate.vaccination?.sd ?? 0)
		case 8:
			cell.textLabel?.text = "tg"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.tg
		case 9:
			cell.textLabel?.text = "vp"
			cell.detailTextLabel?.text = greenCertificate.vaccination?.vp
		default:
			break
		}
	}

	private func prepareTest(_ cell: UITableViewCell, at row: Int) {
		guard certificationType == .test, row < 10 else {
			return
		}
		switch row {
		case 0:
			cell.textLabel?.text = "tg"
			cell.detailTextLabel?.text = greenCertificate.test?.tg
		case 1:
			cell.textLabel?.text = "tt"
			cell.detailTextLabel?.text = greenCertificate.test?.tt
		case 2:
			cell.textLabel?.text = "nm"
			cell.detailTextLabel?.text = greenCertificate.test?.nm ?? "<empty>"
		case 3:
			cell.textLabel?.text = "ma"
			cell.detailTextLabel?.text = greenCertificate.test?.ma ?? "<empty>"
		case 4:
			cell.textLabel?.text = "sc"
			cell.detailTextLabel?.text = greenCertificate.test?.sc
		case 5:
			cell.textLabel?.text = "tr"
			cell.detailTextLabel?.text = greenCertificate.test?.tr
		case 6:
			cell.textLabel?.text = "tc"
			cell.detailTextLabel?.text = greenCertificate.test?.tc ?? "<empty>"
		case 7:
			cell.textLabel?.text = "co"
			cell.detailTextLabel?.text = greenCertificate.test?.co
		case 8:
			cell.textLabel?.text = "is"
			cell.detailTextLabel?.text = greenCertificate.test?.is
		case 9:
			cell.textLabel?.text = "ci"
			cell.detailTextLabel?.text = greenCertificate.test?.ci
		default:
			break
		}
	}

	private func prepareRecovery(_ cell: UITableViewCell, at row: Int) {
		guard certificationType == .recovery, row < 7 else {
			return
		}
		switch row {
		case 0:
			cell.textLabel?.text = "tg"
			cell.detailTextLabel?.text = greenCertificate.recovery?.tg
		case 1:
			cell.textLabel?.text = "fr"
			cell.detailTextLabel?.text = greenCertificate.recovery?.fr
		case 2:
			cell.textLabel?.text = "co"
			cell.detailTextLabel?.text = greenCertificate.recovery?.co
		case 3:
			cell.textLabel?.text = "is"
			cell.detailTextLabel?.text = greenCertificate.recovery?.is
		case 4:
			cell.textLabel?.text = "df"
			cell.detailTextLabel?.text = greenCertificate.recovery?.df
		case 5:
			cell.textLabel?.text = "du"
			cell.detailTextLabel?.text = greenCertificate.recovery?.du
		case 6:
			cell.textLabel?.text = "ci"
			cell.detailTextLabel?.text = greenCertificate.recovery?.ci
		default:
			break
		}
	}
}

fileprivate extension Data {
	func hexEncodedString() -> String {
		return map {
			String(format: "%02hhx", $0)
		}.joined()
	}
}
