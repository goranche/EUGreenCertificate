//
//  EUGreenCertificateName.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SwiftCBOR

public struct EUGreenCertificateName {

	public let foreName: String?
	public let surName: String

	public let foreNameStandard: String?
	public let surNameStandard: String

	public var fullName: String {
		"\(foreName ?? "") \(surName)"
	}

	public var standardName: String {
		"\(surNameStandard)<<\(foreNameStandard ?? "")"
	}

	public var passportName: String {
		standardName
	}

	init(_ cborData: [CBOR: CBOR]) throws {
		guard case .utf8String(let fnString) = cborData["fn"], case .utf8String(let fntString) = cborData["fnt"] else {
			throw EUGreenCertificate.EUGreenCertificateErrors.invalidPayload
		}

		surName = fnString
		surNameStandard = fntString

		if case .utf8String(let gnString) = cborData["gn"] {
			foreName = gnString
		} else {
			foreName = nil
		}

		if case .utf8String(let gntString) = cborData["gnt"] {
			foreNameStandard = gntString
		} else {
			foreNameStandard = nil
		}
	}
}
