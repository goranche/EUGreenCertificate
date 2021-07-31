//
//  CertificateSectionDataSource.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

protocol CertificateSectionDataSource {
	var title: String { get }
	var numberOfRows: Int { get }
	init(using greenCertificate: EUGreenCertificate, andReuseId reuseIdentifier: String)
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
