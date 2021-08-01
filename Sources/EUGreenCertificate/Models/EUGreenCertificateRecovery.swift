//
//  EUGreenCertificateRecovery.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateRecovery {

	public let tg: String
	public let diseaseAgent: DiseaseAgent
	public let fr: String
	public let firstPositiveTest: Date
	public let co: String
	public let countryOfTest: CountryCode
	public let `is`: String
	public let certificateIssuer: String
	public let df: String
	public let certificateValidFrom: Date
	public let du: String
	public let certificateValidTill: Date
	public let ci: String
	public let certificateId: String

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let tgString) = cborData["tg"], case .utf8String(let frString) = cborData["fr"], case .utf8String(let coString) = cborData["co"], case .utf8String(let isString) = cborData["is"], case .utf8String(let dfString) = cborData["df"], case .utf8String(let duString) = cborData["du"], case .utf8String(let ciString) = cborData["ci"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		tg = tgString
		diseaseAgent = DiseaseAgent(rawValue: tg) ?? .unknown
		fr = frString
		co = coString
		countryOfTest = CountryCode(rawValue: co) ?? .unknown
		`is` = isString
		certificateIssuer = `is`
		df = dfString
		du = duString
		ci = ciString
		certificateId = ci

		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd"
		guard let first = dateFormatter.date(from: fr), let from = dateFormatter.date(from: df), let till = dateFormatter.date(from: du) else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidDateFormat
		}
		firstPositiveTest = first
		certificateValidFrom = from
		certificateValidTill = till
	}
}
