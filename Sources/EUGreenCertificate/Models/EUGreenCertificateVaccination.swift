//
//  EUGreenCertificateVaccination.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateVaccination {

	// TODO: Figure out the exact use of individual fields and give them better names

	public let ci: String
	public let co: String
	public let dn: UInt
	public let dt: String
	public let `is`: String
	public let ma: String
	public let mp: String
	public let sd: UInt
	public let tg: String
	public let vp: String

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let ciString) = cborData["ci"], case .utf8String(let coString) = cborData["co"], case .unsignedInt(let dnUInt) = cborData["dn"], case .utf8String(let dtString) = cborData["dt"], case .utf8String(let isString) = cborData["is"], case .utf8String(let maString) = cborData["ma"], case .utf8String(let mpString) = cborData["mp"], case .unsignedInt(let sdUInt) = cborData["sd"], case .utf8String(let tgString) = cborData["tg"], case .utf8String(let vpString) = cborData["vp"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		ci = ciString
		co = coString
		dn = UInt(dnUInt)
		dt = dtString
		`is` = isString
		ma = maString
		mp = mpString
		sd = UInt(sdUInt)
		tg = tgString
		vp = vpString
	}
}
