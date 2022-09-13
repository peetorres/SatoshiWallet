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

        XCTAssertEqual(sut.cryptos?.count, 5)
    }

    func testServiceSuccessHandlerMutableCryptosWithoutSearch() {
        sut = ListViewModel(service: ListServicesSuccessStub())

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(sut.mutableCryptos?.count, 5)
    }

    func testServiceSuccessHandlerMutableCryptosWithSearch() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "T"

        XCTAssertEqual(sut.mutableCryptos?.count, 3)
    }

    func testSearchingForName() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "Ethereum"

        XCTAssertEqual(sut.mutableCryptos?.count, 1)
    }

    func testSearchingForSymbol() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "BT"

        XCTAssertEqual(sut.mutableCryptos?.count, 1)
    }

    func testSearchingMixedCharacters() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "H"

        XCTAssertEqual(sut.mutableCryptos?.count, 3)
    }

    func testSearchingReloadingDataHandlingOnce() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)
        var reloadingDataHandlers: [(() -> Void)?] = []

        sut.shouldReloadData = { [weak self] in
            reloadingDataHandlers.append(self?.sut.shouldReloadData)
        }
        sut.searchText = "ETH"

        XCTAssertEqual(reloadingDataHandlers.count, 1)
    }

    func testSearchingReloadingDataHandlingMultipleTimes() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        sut.getCryptoList(isBackgroundFetch: false)
        var reloadingDataHandlers: [(() -> Void)?] = []

        sut.shouldReloadData = { [weak self] in
            reloadingDataHandlers.append(self?.sut.shouldReloadData)
        }
        sut.searchText = "E"
        sut.searchText = "T"
        sut.searchText = "H"

        XCTAssertEqual(reloadingDataHandlers.count, 3)
    }

    func testCryptoListCalledOnlyOnceImediatelly() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        var successHandlers: [(() -> Void)?] = []

        sut.handleSuccess = { [weak self] in
            successHandlers.append(self?.sut.handleSuccess)
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(successHandlers.count, 1)
    }

    func testCryptoListServerStarted() {
        sut = ListViewModel(service: ListServicesSuccessStub())

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertNotNil(sut.refreshTimer)
    }

    func testCryptoListServerStopped() {
        sut = ListViewModel(service: ListServicesSuccessStub())

        sut.getCryptoList(isBackgroundFetch: false)
        sut.stopServerCryptoList()

        XCTAssertNil(sut.refreshTimer)
    }

    func testCryptoListCalledAgainWhenServerStart() {
        sut = ListViewModel(service: ListServicesSuccessStub())
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

        wait(for: [expectation], timeout: timeInterval)
    }

    func testHandlingProgressTwice() {
        sut = ListViewModel(service: ListServicesSuccessStub())
        var shouldProgressShowHandlers: [(() -> Void)?] = []

        sut.shouldProgressShow = { [weak self] isShowing in
            guard let self = self else { return }
            shouldProgressShowHandlers.append({ self.sut.shouldProgressShow?(isShowing) })
        }
        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(shouldProgressShowHandlers.count, 2)
    }
}
