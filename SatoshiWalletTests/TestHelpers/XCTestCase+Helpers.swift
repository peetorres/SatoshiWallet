//
//  XCTestCase+Helpers.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 08/09/22.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject,
                         file: StaticString = #filePath,
                         line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }

    func testInitWithCoder(of viewController: UIViewController) {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let viewController = type(of: viewController).init(coder: archiver)
        XCTAssertNil(viewController)
    }
}
