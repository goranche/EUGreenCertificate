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

	// TODO: Figure out the exact use of individual fields and give them better names

	public let tg: String
	public let tt: String
	public let nm: String?
	public let ma: String?
	public let sc: String
	public let tr: String
	public let tc: String?
	public let co: String
	public let `is`: String
	public let ci: String

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let tgString) = cborData["tg"], case .utf8String(let ttString) = cborData["tt"], case .tagged(_, let scValue) = cborData["sc"], case .utf8String(let scString) = scValue, case .utf8String(let trString) = cborData["tr"], case .utf8String(let coString) = cborData["co"], case .utf8String(let isString) = cborData["is"], case .utf8String(let ciString) = cborData["ci"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		tg = tgString
		tt = ttString
		sc = scString
		tr = trString
		co = coString
		`is` = isString
		ci = ciString

		if case .utf8String(let nmString) = cborData["nm"] {
			nm = nmString
		} else {
			nm = nil
		}

		if case .utf8String(let maString) = cborData["ma"] {
			ma = maString
		} else {
			ma = nil
		}

		if case .utf8String(let tcString) = cborData["tc"] {
			tc = tcString
		} else {
			tc = nil
		}
	}
}
