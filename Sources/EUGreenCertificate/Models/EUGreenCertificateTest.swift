//
//  EUGreenCertificateTest.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateTest: EUGreenCertificateDate {

	public let tg: String
	public let diseaseAgent: DiseaseAgent
	public let tt: String
	public let testType: LabTestType
	public let nm: String?
	public let testName: String?
	public let ma: String?
	public let testDeviceId: String?
	public let sc: String
	private (set) public var sampleCollected: Date = Date()
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
		var scString: String

		guard case .utf8String(let tgString) = cborData["tg"], case .utf8String(let ttString) = cborData["tt"], case .utf8String(let trString) = cborData["tr"], case .utf8String(let coString) = cborData["co"], case .utf8String(let isString) = cborData["is"], case .utf8String(let ciString) = cborData["ci"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		// For some reason the t/sc field is a .tagged instead of an .utf8String 🤦‍♂️
		// I've noticed this mainly in slovene QR codes with tests in them
		if case .utf8String(let tempString) = cborData["sc"] {
			scString = tempString
		} else if case .tagged(_, let tempValue) = cborData["sc"], case .utf8String(let tempString) = tempValue {
			scString = tempString
		} else {
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

		sampleCollected = try euDate(from: sc)
	}
}
