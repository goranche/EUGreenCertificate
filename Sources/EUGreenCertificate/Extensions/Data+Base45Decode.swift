//
//  Data+Base45Decode.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation

extension Data {

	public enum Base45Error: Error {
		case invalidCharacter
		case invalidLength
		case dataOverflow
	}

	init(base45Encoded base45String: String) throws {
		self.init()

		let alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:"
		var tempData = Data()

		for character in base45String.uppercased() {
			guard let foundIndex = alphabet.firstIndex(of: character) else {
				throw Base45Error.invalidCharacter
			}
			tempData.append(UInt8(alphabet.distance(from: alphabet.startIndex, to: foundIndex)))
		}

		for step in stride(from: 0, to: tempData.count, by: 3) {
			guard tempData.count - step >= 2 else {
				throw Base45Error.invalidLength
			}
			var tempValue = UInt32(tempData[step]) + UInt32(tempData[step + 1]) * 45
			if tempData.count - step >= 3 {
				tempValue += UInt32(tempData[step + 2]) * 2025
				guard tempValue / 256 <= UInt8.max else {
					throw Base45Error.dataOverflow
				}
				self.append(UInt8(tempValue / 256))
			}
			self.append(UInt8(tempValue % 256))
		}
	}
}
