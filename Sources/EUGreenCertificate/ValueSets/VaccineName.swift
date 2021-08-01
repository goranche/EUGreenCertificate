// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-medicinal-product.json
import Foundation
public enum VaccineName: String {
	case unknown = "unknown"
	case eu_1_20_1507 = "EU/1/20/1507"
	case coronavac = "CoronaVac"
	case convidecia = "Convidecia"
	case eu_1_21_1529 = "EU/1/21/1529"
	case epivaccorona = "EpiVacCorona"
	case covaxin = "Covaxin"
	case bbibp_corv = "BBIBP-CorV"
	case eu_1_20_1525 = "EU/1/20/1525"
	case inactivated_sars_cov_2_vero_cell = "Inactivated-SARS-CoV-2-Vero-Cell"
	case eu_1_20_1528 = "EU/1/20/1528"
	case cvncov = "CVnCoV"
	case sputnik_v = "Sputnik-V"
	var display: String {
		switch self {
		case .unknown: return "unknown"
		case .eu_1_20_1507: return "COVID-19 Vaccine Moderna"
		case .coronavac: return "CoronaVac"
		case .convidecia: return "Convidecia"
		case .eu_1_21_1529: return "Vaxzevria"
		case .epivaccorona: return "EpiVacCorona"
		case .covaxin: return "Covaxin (also known as BBV152 A, B, C)"
		case .bbibp_corv: return "BBIBP-CorV"
		case .eu_1_20_1525: return "COVID-19 Vaccine Janssen"
		case .inactivated_sars_cov_2_vero_cell: return "Inactivated SARS-CoV-2 (Vero Cell)"
		case .eu_1_20_1528: return "Comirnaty"
		case .cvncov: return "CVnCoV"
		case .sputnik_v: return "Sputnik-V"
		}
	}
}
