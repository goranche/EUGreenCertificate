//
//  DetailViewController.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import UIKit
import EUGreenCertificate

class DetailViewController: UITableViewController {

	private var dataSource: GreenCertificateDataSource! = nil

	var greenCertificate: EUGreenCertificate? = nil {
		didSet {
			guard let tableView = tableView, let greenCertificate = greenCertificate else {
				tableView?.dataSource = nil
				return
			}
			dataSource = GreenCertificateDataSource(using: greenCertificate, andReuseId: "reuseIdentifier")
			tableView.dataSource = dataSource
		}
	}
}
