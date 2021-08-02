//
//  EUGreenCertificateVaccination.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateVaccination: EUGreenCertificateDate {

	public let ci: String
	public let certificateId: String
	public let co: String
	public let administrationCountry: CountryCode
	public let dn: UInt
	private (set) public var vaccinationDate: Date = Date()
	public let doseInSeries: UInt
	public let dt: String
	public let `is`: String
	public let certificateIssuer: String
	public let ma: String
	public let vaccineManufacturer: VaccineManufacturer
	public let mp: String
	public let vaccineName: VaccineName
	public let sd: UInt
	public let totalInSeries: UInt
	public let tg: String
	public let diseaseAgent: DiseaseAgent
	public let vp: String
	public let vaccineProphylaxis: VaccineProphylaxis

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let ciString) = cborData["ci"], case .utf8String(let coString) = cborData["co"], case .unsignedInt(let dnUInt) = cborData["dn"], case .utf8String(let dtString) = cborData["dt"], case .utf8String(let isString) = cborData["is"], case .utf8String(let maString) = cborData["ma"], case .utf8String(let mpString) = cborData["mp"], case .unsignedInt(let sdUInt) = cborData["sd"], case .utf8String(let tgString) = cborData["tg"], case .utf8String(let vpString) = cborData["vp"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		ci = ciString
		certificateId = ci
		co = coString
		administrationCountry = CountryCode(rawValue: co) ?? .unknown
		dn = UInt(dnUInt)
		doseInSeries = dn
		dt = dtString
		`is` = isString
		certificateIssuer = `is`
		ma = maString
		vaccineManufacturer = VaccineManufacturer(rawValue: ma) ?? .unknown
		mp = mpString
		vaccineName = VaccineName(rawValue: mp) ?? .unknown
		sd = UInt(sdUInt)
		totalInSeries = sd
		tg = tgString
		diseaseAgent = DiseaseAgent(rawValue: tg) ?? .unknown
		vp = vpString
		vaccineProphylaxis = VaccineProphylaxis(rawValue: vp) ?? .unknown

		vaccinationDate = try euDate(from: dt)
	}
}
