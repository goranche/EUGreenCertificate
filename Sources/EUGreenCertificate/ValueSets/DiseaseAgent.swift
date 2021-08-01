// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/disease-agent-targeted.json
import Foundation
enum DiseaseAgent: String {
	case unknown = "unknown"
	case covid_19 = "840539006"
	var display: String {
		switch self {
		case .unknown: return "unknown"
		case .covid_19: return "COVID-19"
		}
	}
}
