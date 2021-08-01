//
//  EUGreenCertificate.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation
import SWCompression
import SwiftCBOR

public struct EUGreenCertificate {

	public enum EUGreenCertificateErrors: LocalizedError {
		case unknownError
		case invalidData
		case base45Error
		case decompressError
		case cborError
		case invalidPayload
		case invalidDateFormat

		public var errorDescription: String? {
			var response: String
			switch self {
			case .invalidData:
				response = "No valid EU green certificate data found"
			case .base45Error:
				response = "An error occurred while base45 decoding data"
			case .decompressError:
				response = "An error occurred while decompressing data"
			case .cborError:
				response = "An error occurred while parsing the data"
			case .invalidPayload:
				response = "The data is in an invalid format"
			case .invalidDateFormat:
				response = "A date field was provided in an unexptected format"
			default:
				response = "An unspecified error occurred"
			}
			return NSLocalizedString(response, comment: "")
		}
	}

	public enum EUGreenCertificationType {
		case unknown
		case vaccination
		case test
		case recovery
	}

	public let certificationType: EUGreenCertificationType

	public let keyIdData: Data

	public let version: String

	public let issuerCountry: CountryCode

	public let issueDate: Date
	public let expirationDate: Date

	public let dateOfBirth: String

	public let name: EUGreenCertificateName

	public let vaccination: EUGreenCertificateVaccination?
	public let test: EUGreenCertificateTest?
	public let recovery: EUGreenCertificateRecovery?

	init(_ cborData: CBOR) throws {
		guard case .tagged(let tag, let valueArray) = cborData, tag == CBOR.Tag(rawValue: 18) else {
			throw EUGreenCertificateErrors.invalidPayload
		}

		guard case .byteString(let signatureByteString) = valueArray[0], let signatureData = try CBOR.decode(signatureByteString), case .byteString(let keyIdData) = signatureData[4] else {
			throw EUGreenCertificateErrors.invalidPayload
		}

		self.keyIdData = Data(keyIdData)

		guard case .byteString(let payloadByteString) = valueArray[2], let payloadData = try CBOR.decode(payloadByteString) else {
			throw EUGreenCertificateErrors.invalidPayload
		}

		guard case .unsignedInt(let issueTimestamp) = payloadData[6], case .unsignedInt(let expirationTimestamp) = payloadData[4], case .utf8String(let issuerCountry) = payloadData[1], case .map(let valueMap) = payloadData[CBOR.negativeInt(259)]?[1] else {
			throw EUGreenCertificateErrors.invalidPayload
		}

		self.issuerCountry = CountryCode(rawValue: issuerCountry) ?? .unknown

		issueDate = Date(timeIntervalSince1970: TimeInterval(issueTimestamp))
		expirationDate = Date(timeIntervalSince1970: TimeInterval(expirationTimestamp))

		guard case .utf8String(let dateOfBirth) = valueMap["dob"], case .utf8String(let version) = valueMap["ver"] else {
			throw EUGreenCertificateErrors.invalidPayload
		}

		self.version = version
		switch dateOfBirth.count {
		case ..<4:
			self.dateOfBirth = ""
		case 4..<7:
			self.dateOfBirth = "\(dateOfBirth)-XX"
		case 7..<10:
			self.dateOfBirth = "\(dateOfBirth)-XX"
		default:
			self.dateOfBirth = dateOfBirth
		}

		guard case .map(let namMap) = valueMap["nam"] else {
			throw EUGreenCertificateErrors.invalidPayload
		}
		name = try EUGreenCertificateName(namMap)

		if case .array(let vArray) = valueMap["v"], case .map(let vMap) = vArray.first {
			vaccination = try EUGreenCertificateVaccination(vMap)
		} else {
			vaccination = nil
		}

		if case .array(let tArray) = valueMap["t"], case .map(let tMap) = tArray.first {
			test = try EUGreenCertificateTest(tMap)
		} else {
			test = nil
		}

		if case .array(let rArray) = valueMap["r"], case .map(let rMap) = rArray.first {
			recovery = try EUGreenCertificateRecovery(rMap)
		} else {
			recovery = nil
		}

		if let _ = vaccination {
			certificationType = .vaccination
		} else if let _ = test {
			certificationType = .test
		} else if let _ = recovery {
			certificationType = .recovery
		} else {
			throw EUGreenCertificateErrors.invalidPayload
		}
	}

	public static func decode(_ qrData: String) -> Result<EUGreenCertificate, EUGreenCertificateErrors> {
		guard qrData.uppercased().hasPrefix("HC1") else {
			return .failure(.invalidData)
		}

		do {
			let compressedData = try Data(base45Encoded: String(qrData[qrData.index(qrData.startIndex, offsetBy: 4)..<qrData.endIndex]))

			// Make sure we have data and it's zlib compressed
			guard compressedData.count > 0, compressedData[0] == 0x78 else {
				return .failure(.invalidData)
			}

			let payloadData = try ZlibArchive.unarchive(archive: compressedData)

			guard let cborData = try CBOR.decode([UInt8](payloadData)) else {
				return .failure(.cborError)
			}

			return .success(try EUGreenCertificate(cborData))

		} catch is Data.Base45Error {
			return .failure(.base45Error)
		} catch is DeflateError, is ZlibError {
			return .failure(.decompressError)
		} catch is CBORError {
			return .failure(.cborError)
		} catch {
			return .failure(error as? EUGreenCertificateErrors ?? .unknownError)
		}
	}
}
