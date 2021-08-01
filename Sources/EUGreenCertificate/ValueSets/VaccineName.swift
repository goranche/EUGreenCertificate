// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-medicinal-product.json
import Foundation
public enum VaccineName: String {
	case unknown = "unknown"
	case eu_1_20_1507 = "EU/1/20/1507"
	case sputnik_v = "Sputnik-V"
	case eu_1_21_1529 = "EU/1/21/1529"
	case bbibp_corv = "BBIBP-CorV"
	case epivaccorona = "EpiVacCorona"
	case eu_1_20_1525 = "EU/1/20/1525"
	case cvncov = "CVnCoV"
	case covaxin = "Covaxin"
	case convidecia = "Convidecia"
	case eu_1_20_1528 = "EU/1/20/1528"
	case inactivated_sars_cov_2_vero_cell = "Inactivated-SARS-CoV-2-Vero-Cell"
	case coronavac = "CoronaVac"
	public var display: String {
		switch self {
		case .unknown: return "unknown"
		case .eu_1_20_1507: return "COVID-19 Vaccine Moderna"
		case .sputnik_v: return "Sputnik-V"
		case .eu_1_21_1529: return "Vaxzevria"
		case .bbibp_corv: return "BBIBP-CorV"
		case .epivaccorona: return "EpiVacCorona"
		case .eu_1_20_1525: return "COVID-19 Vaccine Janssen"
		case .cvncov: return "CVnCoV"
		case .covaxin: return "Covaxin (also known as BBV152 A, B, C)"
		case .convidecia: return "Convidecia"
		case .eu_1_20_1528: return "Comirnaty"
		case .inactivated_sars_cov_2_vero_cell: return "Inactivated SARS-CoV-2 (Vero Cell)"
		case .coronavac: return "CoronaVac"
		}
	}
}
