//
//  EUGreenCertificateTest.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateTest {

	public let tg: String
	public let diseaseAgent: DiseaseAgent
	public let tt: String
	public let testType: LabTestType
	public let nm: String?
	public let testName: String?
	public let ma: String?
	public let testDeviceId: String?
	public let sc: String
	public let sampleCollected: Date
	public let tr: String
	public let testResult: LabResult
	public let tc: String?
	public let testCenter: String?
	public let co: String
	public let countryOfTest: CountryCode
	public let `is`: String
	public let certificateIssuer: String
	public let ci: String
	public let certificateId: String

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let tgString) = cborData["tg"], case .utf8String(let ttString) = cborData["tt"], case .tagged(_, let scValue) = cborData["sc"], case .utf8String(let scString) = scValue, case .utf8String(let trString) = cborData["tr"], case .utf8String(let coString) = cborData["co"], case .utf8String(let isString) = cborData["is"], case .utf8String(let ciString) = cborData["ci"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		tg = tgString
		diseaseAgent = DiseaseAgent(rawValue: tg) ?? .unknown
		tt = ttString
		testType = LabTestType(rawValue: tt) ?? .unknown
		sc = scString
		tr = trString
		testResult = LabResult(rawValue: tr) ?? .unknown
		co = coString
		countryOfTest = CountryCode(rawValue: co) ?? .unknown
		`is` = isString
		certificateIssuer = `is`
		ci = ciString
		certificateId = ci

		if case .utf8String(let nmString) = cborData["nm"] {
			nm = nmString
		} else {
			nm = nil
		}
		testName = nm

		if case .utf8String(let maString) = cborData["ma"] {
			ma = maString
		} else {
			ma = nil
		}
		testDeviceId = ma

		if case .utf8String(let tcString) = cborData["tc"] {
			tc = tcString
		} else {
			tc = nil
		}
		testCenter = tc

		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		guard let tempDate = dateFormatter.date(from: sc) else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidDateFormat
		}
		sampleCollected = tempDate
	}
}
