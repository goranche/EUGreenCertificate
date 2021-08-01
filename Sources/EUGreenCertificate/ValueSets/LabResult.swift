// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/test-result.json
import Foundation
public enum LabResult: String {
	case unknown = "unknown"
	case not_detected = "260415000"
	case detected = "260373001"
	public var display: String {
		switch self {
		case .unknown: return "unknown"
		case .not_detected: return "Not detected"
		case .detected: return "Detected"
		}
	}
}
