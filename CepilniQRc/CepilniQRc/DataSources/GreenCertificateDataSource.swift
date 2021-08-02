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

	private let greenCertificate: EUGreenCertificate
	private let reuseIdentifier: String

	private let dateFormatter = DateFormatter()

	private let sectionSources: [CertificateSectionDataSource]

	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String) {
		self.greenCertificate = greenCertificate
		self.reuseIdentifier = reuseIdentifier

		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none

		var sections: [CertificateSectionDataSource] = [
			EUGreenCertificateNameSection(using: greenCertificate, andReuseId: reuseIdentifier),
			EUGreenCertificateGeneralSection(using: greenCertificate, andReuseId: reuseIdentifier)
		]

		switch greenCertificate.certificationType {
		case .vaccination:
			sections.append(EUGreenCertificateVaccinationSection(using: greenCertificate, andReuseId: reuseIdentifier))
		case .test:
			sections.append(EUGreenCertificateTestSection(using: greenCertificate, andReuseId: reuseIdentifier))
		case .recovery:
			sections.append(EUGreenCertificateRecoverySection(using: greenCertificate, andReuseId: reuseIdentifier))
		default:
			break
		}

		sectionSources = sections
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		sectionSources.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		section < sectionSources.count ? sectionSources[section].numberOfRows : 0
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		section < sectionSources.count ? sectionSources[section].title : nil
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard indexPath.section < sectionSources.count else {
			return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
		}
		return sectionSources[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
	}
}
