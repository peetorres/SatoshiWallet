//
//  ListViewModelTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 12/09/22.
//

import XCTest
@testable import SatoshiWallet

class ListViewModelTests: XCTestCase {
    // MARK: Properties
    var sut: ListViewModel!

    // MARK: Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    // MARK: Test Methods
    func testServiceSuccessHandlerCryptosCounting() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)
        XCTAssertEqual(sut.cryptos?.count, 4)
    }

    func testServiceSuccessHandlerMutableCryptosWithoutSearch() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)
        XCTAssertEqual(sut.mutableCryptos?.count, 4)
    }

    func testServiceSuccessHandlerMutableCryptosWithSearch() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "T"

        XCTAssertEqual(sut.mutableCryptos?.count, 2)
    }
}
