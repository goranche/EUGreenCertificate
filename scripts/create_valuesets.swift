#!/usr/bin/swift
import Foundation

let release = "release/1.3.0"
let base = "https://raw.githubusercontent.com/ehn-dcc-development/ehn-dcc-schema/\(release)/valuesets"

guard let baseURL = URL(string: base) else {
	fatalError("Couldn't convert base baseUrl to a URL")
}

let unknownCase = "\tcase unknown = \"unknown\""
let unknownDisplay = "\t\tcase .unknown: return \"unknown\""
let displaySequence = [
	"\tpublic var display: String {",
	"\t\tswitch self {",
	unknownDisplay
]
let closingSequence = [
	"\t\t}",
	"\t}",
	"}",
	""
]

// MARK: - ValueConverter

protocol ValueConverter {
	var input: String { get }
	var output: String { get }
	func output(_ values: [String: EUValSetValue], to filename: String)
}

// MARK: - CountryCode

struct CountryCodesConverter: ValueConverter {
	let input = "country-2-codes.json"
	let output = "CountryCode.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/country-2-codes.json",
			"import Foundation",
			"public enum CountryCode: String {",
			unknownCase
		]
		values.keys.forEach {
			outputArray.append("\tcase country_\($0.lowercased()) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			outputArray.append("\t\tcase .country_\($0.lowercased()): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - DiseaseAgent

struct DiseaseAgentsConverter: ValueConverter {
	let input = "disease-agent-targeted.json"
	let output = "DiseaseAgent.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/disease-agent-targeted.json",
			"import Foundation",
			"public enum DiseaseAgent: String {",
			unknownCase
		]
		values.keys.forEach {
			guard let caseLabel = values[$0]?.display.lowercased().replacingOccurrences(of: "-", with: "_") else {
				return
			}
			outputArray.append("\tcase \(caseLabel) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			guard let caseLabel = values[$0]?.display.lowercased().replacingOccurrences(of: "-", with: "_") else {
				return
			}
			outputArray.append("\t\tcase .\(caseLabel): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - LabTestManufacturer

struct LabTestManufacturersConverter: ValueConverter {
	let input = "test-manf.json"
	let output = "LabTestManufacturer.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/test-manf.json",
			"import Foundation",
			"public enum LabTestManufacturer: String {",
			unknownCase
		]
		values.keys.forEach {
			outputArray.append("\tcase manufacturer\($0) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			outputArray.append("\t\tcase .manufacturer\($0): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - LabResult

struct LabResultConverter: ValueConverter {
	let input = "test-result.json"
	let output = "LabResult.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/test-result.json",
			"import Foundation",
			"public enum LabResult: String {",
			unknownCase
		]
		values.keys.forEach {
			guard let caseLabel = values[$0]?.display.lowercased().replacingOccurrences(of: " ", with: "_") else {
				return
			}
			outputArray.append("\tcase \(caseLabel) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			guard let caseLabel = values[$0]?.display.lowercased().replacingOccurrences(of: " ", with: "_") else {
				return
			}
			outputArray.append("\t\tcase .\(caseLabel): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - LabTestType

struct LabTestTypeConverter: ValueConverter {
	let input = "test-type.json"
	let output = "LabTestType.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/test-type.json",
			"import Foundation",
			"public enum LabTestType: String {",
			unknownCase
		]
		values.keys.forEach {
			outputArray.append("\tcase \($0.lowercased().replacingOccurrences(of: "-", with: "_")) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			outputArray.append("\t\tcase .\($0.lowercased().replacingOccurrences(of: "-", with: "_")): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - VaccineManufacturer

struct VaccineManufacturerConverter: ValueConverter {
	let input = "vaccine-mah-manf.json"
	let output = "VaccineManufacturer.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-mah-manf.json",
			"import Foundation",
			"public enum VaccineManufacturer: String {",
			unknownCase
		]
		values.keys.forEach {
			outputArray.append("\tcase \($0.lowercased().replacingOccurrences(of: "-", with: "_")) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			outputArray.append("\t\tcase .\($0.lowercased().replacingOccurrences(of: "-", with: "_")): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - VaccineName

struct VaccineNameConverter: ValueConverter {
	let input = "vaccine-medicinal-product.json"
	let output = "VaccineName.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-medicinal-product.json",
			"import Foundation",
			"public enum VaccineName: String {",
			unknownCase
		]
		values.keys.forEach {
			outputArray.append("\tcase \($0.lowercased().replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "-", with: "_")) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			outputArray.append("\t\tcase .\($0.lowercased().replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "-", with: "_")): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - VaccineProphylaxis

struct VaccineProphylaxisConverter: ValueConverter {
	let input = "vaccine-prophylaxis.json"
	let output = "VaccineProphylaxis.swift"
	func output(_ values: [String: EUValSetValue], to filename: String) {
		var outputArray = [
			"// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-prophylaxis.json",
			"import Foundation",
			"public enum VaccineProphylaxis: String {",
			unknownCase
		]
		values.keys.forEach {
			outputArray.append("\tcase prophylaxis_\($0.lowercased()) = \"\($0)\"")
		}
		outputArray.append(contentsOf: displaySequence)
		values.keys.forEach {
			outputArray.append("\t\tcase .prophylaxis_\($0.lowercased()): return \"\(values[$0]?.display ?? "--")\"")
		}
		outputArray.append(contentsOf: closingSequence)
		let outputString = outputArray.joined(separator: "\n")
		do {
			try outputString.data(using: .utf8)?.write(to: URL(fileURLWithPath: filename))
		} catch {
			fatalError("Exception while writing data: \(error.localizedDescription)")
		}
	}
}

// MARK: - EU Value Sets

struct EUValSetValue: Decodable {
	let display: String
	let lang: String
	let active: Bool
	let system: String
}

struct EUValSetArray: Decodable {
	let values: [String: EUValSetValue]

	private struct DynamicCodingKeys: CodingKey {
		var stringValue: String
		init?(stringValue: String) {
			self.stringValue = stringValue
		}
		var intValue: Int?
		init?(intValue: Int) {
			return nil
		}
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
		var tempValues = [String: EUValSetValue]()
		for key in container.allKeys {
			let value = try container.decode(EUValSetValue.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
			if value.active {
				tempValues[key.stringValue] = value
			}
		}
		values = tempValues
	}
}

struct EUValueSet: Decodable {
	let valueSetId: String
	let valueSetDate: String
	let valueSetValues: EUValSetArray
}

// MARK: - Main code

let session = URLSession(configuration: .default)
let dispatchGroup = DispatchGroup()

let converters: [ValueConverter] = [
	CountryCodesConverter(),
	DiseaseAgentsConverter(),
	LabTestManufacturersConverter(),
	LabResultConverter(),
	LabTestTypeConverter(),
	VaccineManufacturerConverter(),
	VaccineNameConverter(),
	VaccineProphylaxisConverter()
]

converters.forEach { converter in
	let jsonURL = baseURL.appendingPathComponent(converter.input)
	session.dataTask(with: jsonURL) { data, response, error in
		guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			fatalError("An error occurred while fetching json data: \(error?.localizedDescription ?? "<unknown>")")
		}
		do {
			let values = try JSONDecoder().decode(EUValueSet.self, from: data)
			converter.output(values.valueSetValues.values, to: converter.output)
			dispatchGroup.leave()
		} catch {
			fatalError("An error occurred while decoding data: \(error.localizedDescription)")
		}
	}.resume()
	dispatchGroup.enter()
}

dispatchGroup.wait()
