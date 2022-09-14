//
//  Helpers.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

extension XCTestCase {
    func assert(_ viewController: UIViewController, named: String) {
        viewController.overrideUserInterfaceStyle = .dark
        verifyViewController(viewController, named: named + "+Darkmode")

        viewController.overrideUserInterfaceStyle = .light
        verifyViewController(viewController, named: named + "+Lightmode")
    }

    func verifyViewController(_ viewController: UIViewController, named: String) {
        let devices: [String: ViewImageConfig] = ["iPhoneX": .iPhoneX,
                                                  "iPhone8": .iPhone8,
                                                  "iPhoneSe": .iPhoneSe]

        let results = devices.map { device in
            verifySnapshot(matching: viewController,
                           as: .image(on: device.value),
                           named: "\(named)-\(device.key)",
                           testName: named)
        }

        results.forEach { XCTAssertNil($0) }
    }
}
