//
//  DetailsViewControllerTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class DetailsViewControllerTests: XCTestCase {
    // MARK: Test Controller Behaviors
    func testInitWithCoder() {
        let sut: DetailsViewController = makeSut()

        testInitWithCoder(of: sut)
    }

    // MARK: Test Screen Elements
    func testNavigationTitle() {
        let sut: DetailsViewController = makeSut()

        XCTAssertEqual(sut.title, sut.viewModel.name())
    }

    func testButtonsEnabled() {
        let sut: DetailsViewController = makeSut()

        XCTAssertTrue(sut.explorerButton.button.isEnabled)
        XCTAssertTrue(sut.learnMoreButton.button.isEnabled)
    }

    func testExploreButtonPressedHandler() {
        let exp = expectation(description: "waiting")
        let sut: DetailsViewController = makeSut()

        sut.explorerPressed = { _ in
            exp.fulfill()
        }

        sut.explorerButton.button.sendActions(for: .touchUpInside)

        wait(for: [exp], timeout: 1)
    }

    func testLearnMoreButtonPressedHandler() {
        let exp = expectation(description: "waiting")
        let sut: DetailsViewController = makeSut()

        sut.learnMorePressed = { _ in
            exp.fulfill()
        }

        sut.learnMoreButton.button.sendActions(for: .touchUpInside)

        wait(for: [exp], timeout: 1)
    }

    func testJumpBearMarketButtonPressedHandler() {
        let exp = expectation(description: "waiting")
        let sut: DetailsViewController = makeSut()

        sut.jumpBearMarketPressed = { _ in
            exp.fulfill()
        }

        sut.jumpBearMarketButton.button.sendActions(for: .touchUpInside)

        wait(for: [exp], timeout: 1)
    }

    func testNotShowingLabelsDummyCrypto() {
        let sut: DetailsViewController = makeSut(with: .makeDUMMY())

        XCTAssertEqual(sut.maxSupplyLabel.text, nil)
        XCTAssertEqual(sut.explorerLabel.text, nil)
    }
}

extension DetailsViewControllerTests {
    func makeSut(with crypto: Crypto = .makeETH(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> DetailsViewController {
        let viewModel = DetailsViewModel(crypto: crypto)
        let sut = DetailsViewController(viewModel: viewModel)

        _ = sut.view

        checkMemoryLeak(for: sut)

        return sut
    }
}
