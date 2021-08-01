//
//  EUGreenCertificateVaccinationSection.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

struct EUGreenCertificateVaccinationSection: CertificateSectionDataSource {

	var title: String {
		return NSLocalizedString("Vaccination data", comment: "")
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

		dateFormatter.timeStyle = .none
		dateFormatter.dateStyle = .medium
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

		guard let vaccination = greenCertificate.vaccination else {
			return cell
		}

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = NSLocalizedString("Unique certificate identifier", comment: "")
			cell.detailTextLabel?.text = vaccination.certificateId
		case 1:
			cell.textLabel?.text = NSLocalizedString("State or third country of administration", comment: "")
			cell.detailTextLabel?.text = vaccination.administrationCountry.display
		case 2:
			cell.textLabel?.text = NSLocalizedString("Number in a series of doses", comment: "")
			cell.detailTextLabel?.text = String(vaccination.totalInSeries)
		case 3:
			cell.textLabel?.text = NSLocalizedString("Date of vaccination", comment: "")
			cell.detailTextLabel?.text = dateFormatter.string(from: vaccination.vaccinationDate)
		case 4:
			cell.textLabel?.text = NSLocalizedString("Certificate issuer", comment: "")
			cell.detailTextLabel?.text = vaccination.certificateIssuer
		case 5:
			cell.textLabel?.text = NSLocalizedString("COVID-19 vaccine manufacturer", comment: "")
			cell.detailTextLabel?.text = vaccination.vaccineManufacturer.display
		case 6:
			cell.textLabel?.text = NSLocalizedString("COVID-19 vaccine product", comment: "")
			cell.detailTextLabel?.text = vaccination.vaccineName.display
		case 7:
			cell.textLabel?.text = NSLocalizedString("Number of doses in series", comment: "")
			cell.detailTextLabel?.text = String(vaccination.doseInSeries)
		case 8:
			cell.textLabel?.text = NSLocalizedString("Disease or agent targeted", comment: "")
			cell.detailTextLabel?.text = vaccination.diseaseAgent.display
		case 9:
			cell.textLabel?.text = NSLocalizedString("COVID-19 vaccine or prophylaxis", comment: "")
			cell.detailTextLabel?.text = vaccination.vaccineProphylaxis.display
		default:
			break
		}

		return cell
	}
}
