// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-mah-manf.json
import Foundation
public enum VaccineManufacturer: String {
	case unknown = "unknown"
	case org_100013793 = "ORG-100013793"
	case org_100010771 = "ORG-100010771"
	case gamaleya_research_institute = "Gamaleya-Research-Institute"
	case bharat_biotech = "Bharat-Biotech"
	case org_100030215 = "ORG-100030215"
	case org_100001417 = "ORG-100001417"
	case org_100031184 = "ORG-100031184"
	case org_100006270 = "ORG-100006270"
	case org_100020693 = "ORG-100020693"
	case org_100001699 = "ORG-100001699"
	case vector_institute = "Vector-Institute"
	case org_100032020 = "ORG-100032020"
	case sinovac_biotech = "Sinovac-Biotech"
	case org_100024420 = "ORG-100024420"
	public var display: String {
		switch self {
		case .unknown: return "unknown"
		case .org_100013793: return "CanSino Biologics"
		case .org_100010771: return "Sinopharm Weiqida Europe Pharmaceutical s.r.o. - Prague location"
		case .gamaleya_research_institute: return "Gamaleya Research Institute"
		case .bharat_biotech: return "Bharat Biotech"
		case .org_100030215: return "Biontech Manufacturing GmbH"
		case .org_100001417: return "Janssen-Cilag International"
		case .org_100031184: return "Moderna Biotech Spain S.L."
		case .org_100006270: return "Curevac AG"
		case .org_100020693: return "China Sinopharm International Corp. - Beijing location"
		case .org_100001699: return "AstraZeneca AB"
		case .vector_institute: return "Vector Institute"
		case .org_100032020: return "Novavax CZ AS"
		case .sinovac_biotech: return "Sinovac Biotech"
		case .org_100024420: return "Sinopharm Zhijun (Shenzhen) Pharmaceutical Co. Ltd. - Shenzhen location"
		}
	}
}
