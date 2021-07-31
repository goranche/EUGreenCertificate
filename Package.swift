// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

//
//  Package.swift
//  EUGreenCertificate
//
//  Created by Goran Blažič on 31/07/2021.
//  Copyright © 2021 Goran Blažič s.p. All rights reserved.
//

import PackageDescription

let package = Package(
	name: "EUGreenCertificate",
	products: [
		.library(
			name: "EUGreenCertificate",
			targets: ["EUGreenCertificate"]),
	],
	dependencies: [
		.package(url: "https://github.com/tsolomko/SWCompression.git", .upToNextMinor(from: "4.5.11")),
		.package(url: "https://github.com/unrelentingtech/SwiftCBOR", .upToNextMinor(from: "0.4.3")),
	],
	targets: [
		.target(
			name: "EUGreenCertificate",
			dependencies: ["SWCompression", "SwiftCBOR"]),
		.testTarget(
			name: "EUGreenCertificateTests",
			dependencies: ["EUGreenCertificate"]),
	]
)
