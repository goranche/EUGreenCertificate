// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/test-type.json
import Foundation
public enum LabTestType: String {
	case unknown = "unknown"
	case lp6464_4 = "LP6464-4"
	case lp217198_3 = "LP217198-3"
	var display: String {
		switch self {
		case .unknown: return "unknown"
		case .lp6464_4: return "Nucleic acid amplification with probe detection"
		case .lp217198_3: return "Rapid immunoassay"
		}
	}
}
