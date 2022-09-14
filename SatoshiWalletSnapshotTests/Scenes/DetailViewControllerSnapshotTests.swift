//
//  DetailViewControllerSnapshotTests.swift
//  SatoshiWalletSnapshotTests
//
//  Created by Pedro Gabriel on 14/09/22.
//

import XCTest
import SnapshotTesting

@testable import SatoshiWallet

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
