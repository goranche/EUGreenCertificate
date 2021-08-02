//
//  EUGreenCertificateRecovery.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateRecovery: EUGreenCertificateDate {

	public let tg: String
	public let diseaseAgent: DiseaseAgent
	public let fr: String
	private (set) public var firstPositiveTest: Date = Date()
	public let co: String
	public let countryOfTest: CountryCode
	public let `is`: String
	public let certificateIssuer: String
	public let df: String
	private (set) public var certificateValidFrom: Date = Date()
	public let du: String
	private (set) public var certificateValidTill: Date = Date()
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

		firstPositiveTest = try euDate(from: fr)
		certificateValidFrom = try euDate(from: df)
		certificateValidTill = try euDate(from: du)
	}
}
