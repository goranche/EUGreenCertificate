//
//  AppSettings.swift
//  CepilniQRc
//
//  Created by Goran Blažič on 02/08/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import Foundation

struct AppSettings {

	private let termsAcceptedKey = "termsAccepted"

	static var shared = AppSettings()
	private let userDefaults = UserDefaults.standard

	var termsAccepted: Bool {
		get {
			return userDefaults.bool(forKey: termsAcceptedKey)
		}
		set {
			userDefaults.set(newValue, forKey: termsAcceptedKey)
		}
	}

	private init() {}
}
