//
//  EUGreenCertificateDate.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 02/08/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation

protocol EUGreenCertificateDate {
	func euDate(from: String) throws -> Date
}

extension EUGreenCertificateDate {

	func euDate(from: String) throws -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")

		dateFormatter.dateFormat = "yyyy-MM-dd"
		if let date = dateFormatter.date(from: from) {
			return date
		}

		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		if let date = dateFormatter.date(from: from) {
			return date
		}

		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
		if let date = dateFormatter.date(from: from) {
			return date
		}

		throw EUGreenCertificate.EUGreenCertificateErrors.invalidDateFormat
	}
}
