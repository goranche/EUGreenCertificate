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

	// TODO: Figure out the exact use of individual fields and give them better names

	public let tg: String
	public let fr: String
	public let co: String
	public let `is`: String
	public let df: String
	public let du: String
	public let ci: String

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let tgString) = cborData["tg"], case .utf8String(let frString) = cborData["fr"], case .utf8String(let coString) = cborData["co"], case .utf8String(let isString) = cborData["is"], case .utf8String(let dfString) = cborData["df"], case .utf8String(let duString) = cborData["du"], case .utf8String(let ciString) = cborData["ci"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		tg = tgString
		fr = frString
		co = coString
		`is` = isString
		df = dfString
		du = duString
		ci = ciString
	}
}
