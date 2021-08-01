// Generated from https://github.com/ehn-dcc-development/ehn-dcc-schema => valuesets/vaccine-medicinal-product.json
import Foundation
enum VaccineName: String {
	case unknown = "unknown"
	case eu_1_20_1507 = "EU/1/20/1507"
	case eu_1_20_1525 = "EU/1/20/1525"
	case epivaccorona = "EpiVacCorona"
	case covaxin = "Covaxin"
	case coronavac = "CoronaVac"
	case cvncov = "CVnCoV"
	case inactivated_sars_cov_2_vero_cell = "Inactivated-SARS-CoV-2-Vero-Cell"
	case convidecia = "Convidecia"
	case sputnik_v = "Sputnik-V"
	case bbibp_corv = "BBIBP-CorV"
	case eu_1_20_1528 = "EU/1/20/1528"
	case eu_1_21_1529 = "EU/1/21/1529"
	var display: String {
		switch self {
		case .unknown: return "unknown"
		case .eu_1_20_1507: return "COVID-19 Vaccine Moderna"
		case .eu_1_20_1525: return "COVID-19 Vaccine Janssen"
		case .epivaccorona: return "EpiVacCorona"
		case .covaxin: return "Covaxin (also known as BBV152 A, B, C)"
		case .coronavac: return "CoronaVac"
		case .cvncov: return "CVnCoV"
		case .inactivated_sars_cov_2_vero_cell: return "Inactivated SARS-CoV-2 (Vero Cell)"
		case .convidecia: return "Convidecia"
		case .sputnik_v: return "Sputnik-V"
		case .bbibp_corv: return "BBIBP-CorV"
		case .eu_1_20_1528: return "Comirnaty"
		case .eu_1_21_1529: return "Vaxzevria"
		}
	}
}
