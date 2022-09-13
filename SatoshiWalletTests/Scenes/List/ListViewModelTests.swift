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
        sut = ListViewModel(service: ListServicesSuccessStub())
    }

    // MARK: Test Methods
    func testServiceSuccessHandlerCryptosCounting() {
        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(sut.cryptos?.count, 5)
    }

    func testServiceSuccessHandlerMutableCryptosWithoutSearch() {
        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(sut.mutableCryptos?.count, 5)
    }

    func testServiceSuccessHandlerMutableCryptosWithSearch() {
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "T"

        XCTAssertEqual(sut.mutableCryptos?.count, 3)
    }

    func testCryptoDontChangeWhenSearch() {
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "T"

        XCTAssertEqual(sut.cryptos?.count, 5)
    }

    func testSearchingForName() {
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "Ethereum"

        XCTAssertEqual(sut.mutableCryptos?.count, 1)
    }

    func testSearchingForSymbol() {
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "BT"

        XCTAssertEqual(sut.mutableCryptos?.count, 1)
    }

    func testSearchingMixedCharacters() {
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "H"

        XCTAssertEqual(sut.mutableCryptos?.count, 3)
    }

    func testSearchingReloadingDataHandlingOnce() {
        var reloadingDataHandlers: [(() -> Void)?] = []

        sut.shouldReloadData = { [weak self] in
            reloadingDataHandlers.append(self?.sut.shouldReloadData)
        }

        sut.getCryptoList(isBackgroundFetch: false)
        sut.searchText = "ETH"

        XCTAssertEqual(reloadingDataHandlers.count, 1)
    }

    func testSearchingReloadingDataHandlingMultipleTimes() {
        var reloadingDataHandlers: [(() -> Void)?] = []

        sut.shouldReloadData = { [weak self] in
            reloadingDataHandlers.append(self?.sut.shouldReloadData)
        }

        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "E"
        sut.searchText = "T"
        sut.searchText = "H"

        XCTAssertEqual(reloadingDataHandlers.count, 3)
    }

    func testCryptoListCalledOnlyOnceImediatelly() {
        var successHandlers: [(() -> Void)?] = []

        sut.handleSuccess = { [weak self] in
            successHandlers.append(self?.sut.handleSuccess)
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(successHandlers.count, 1)
    }

    func testCryptoListServerStarted() {
        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertNotNil(sut.refreshTimer)
    }

    func testCryptoListServerStopped() {
        sut.getCryptoList(isBackgroundFetch: false)
        sut.stopServerCryptoList()

        XCTAssertNil(sut.refreshTimer)
    }

    func testCryptoListCalledAgainWhenServerStart() {
        var successHandlers: [(() -> Void)?] = []
        let expectation = expectation(description: "Waiting Timer Fire!")
        let timeInterval = ListViewModel.Constants.timeIntervalFetchInSeconds

        sut.handleSuccess = { [weak self] in
            successHandlers.append(self?.sut.handleSuccess)
        }

        sut.getCryptoList(isBackgroundFetch: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            expectation.fulfill()
            XCTAssertEqual(successHandlers.count, 2)
        }

        wait(for: [expectation], timeout: timeInterval + 1)
    }

    func testHandlingProgressTwiceSuccessStub() {
        var shouldProgressShowHandlers: [(() -> Void)?] = []

        sut.shouldProgressShow = { [weak self] isShowing in
            guard let self = self else { return }
            shouldProgressShowHandlers.append({ self.sut.shouldProgressShow?(isShowing) })
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(shouldProgressShowHandlers.count, 2)
    }

    func testServiceFailureFirstTimeCryptosNil() {
        sut = ListViewModel(service: ListServicesFailureStub())

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertNil(sut.cryptos)
    }

    func testServiceFailureErrorHandler() {
        sut = ListViewModel(service: ListServicesFailureStub())
        var errorHandlers: [((Bool, String) -> Void)?] = []

        sut.handleError = { [weak self] _, _ in
            guard let self = self else { return }
            errorHandlers.append({ _, _ in self.sut.handleError?(false, "") })
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(errorHandlers.count, 1)
    }

    func testHandlingProgressTwiceFailureStub() {
        sut = ListViewModel(service: ListServicesFailureStub())
        var shouldProgressShowHandlers: [(() -> Void)?] = []

        sut.shouldProgressShow = { [weak self] isShowing in
            guard let self = self else { return }
            shouldProgressShowHandlers.append({ self.sut.shouldProgressShow?(isShowing) })
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(shouldProgressShowHandlers.count, 2)
    }
}
