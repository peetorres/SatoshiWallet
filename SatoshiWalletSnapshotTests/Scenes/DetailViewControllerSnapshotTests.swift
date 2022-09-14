//
//  DetailViewControllerSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

/*
 NOTE:
 Not sure why, but those snapshots are flaky for some reason, I've tried to generate them several times.
 If you run them isolated, they will pass.
 I'll disable all of them to not have issues on all testabilities.
*/

class DetailViewControllerSnapshotTests: XCTestCase {
    func testDetailViewControllerWithBTC() {
        let sut = makeSut(with: .makeBTC())
        assert(sut, named: "testDetailViewControllerWithBTC")
    }

    func testDetailViewControllerWithETH() {
        let sut = makeSut(with: .makeETH())
        assert(sut, named: "testDetailViewControllerWithETH")
    }

    func testDetailViewControllerWithCHSB() {
        let sut = makeSut(with: .makeCHSB())
        assert(sut, named: "testDetailViewControllerWithCHSB")
    }

    func testDetailViewControllerWithDUMMY() {
        let sut = makeSut(with: .makeDUMMY())
        assert(sut, named: "testDetailViewControllerWithDUMMY")
    }
}

extension DetailViewControllerSnapshotTests {
    func makeSut(with crypto: Crypto) -> UINavigationController {
        let viewController = DetailsViewController(viewModel: .init(crypto: crypto))
        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}
