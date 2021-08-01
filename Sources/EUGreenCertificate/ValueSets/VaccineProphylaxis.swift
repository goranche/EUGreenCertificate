// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-prophylaxis.json
import Foundation
public enum VaccineProphylaxis: String {
	case unknown = "unknown"
	case prophylaxis_1119349007 = "1119349007"
	case prophylaxis_1119305005 = "1119305005"
	case prophylaxis_j07bx03 = "J07BX03"
	public var display: String {
		switch self {
		case .unknown: return "unknown"
		case .prophylaxis_1119349007: return "SARS-CoV-2 mRNA vaccine"
		case .prophylaxis_1119305005: return "SARS-CoV-2 antigen vaccine"
		case .prophylaxis_j07bx03: return "covid-19 vaccines"
		}
	}
}
