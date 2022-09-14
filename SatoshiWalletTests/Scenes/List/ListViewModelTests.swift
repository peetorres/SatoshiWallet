//
//  ListViewModelTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 12/09/22.
//

import XCTest
@testable import SatoshiWallet

class ListViewModelTests: XCTestCase {
    // MARK: Test Methods
    func testServiceSuccessHandlerCryptosCounting() {
        let sut = makeSut()

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(sut.cryptos?.count, 5)
    }

    func testServiceSuccessHandlerMutableCryptosWithoutSearch() {
        let sut = makeSut()

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(sut.mutableCryptos?.count, 5)
    }

    func testServiceSuccessHandlerMutableCryptosWithSearch() {
        let sut = makeSut()

        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "T"

        XCTAssertEqual(sut.mutableCryptos?.count, 3)
    }

    func testCryptoDontChangeWhenSearch() {
        let sut = makeSut()

        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "T"

        XCTAssertEqual(sut.cryptos?.count, 5)
    }

    func testSearchingForName() {
        let sut = makeSut()

        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "Ethereum"

        XCTAssertEqual(sut.mutableCryptos?.count, 1)
    }

    func testSearchingForSymbol() {
        let sut = makeSut()

        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "BT"

        XCTAssertEqual(sut.mutableCryptos?.count, 1)
    }

    func testSearchingMixedCharacters() {
        let sut = makeSut()
        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "H"

        XCTAssertEqual(sut.mutableCryptos?.count, 3)
    }

    func testSearchingReloadingDataHandlingOnce() {
        let sut = makeSut()
        var reloadingDataHandlers: [(() -> Void)?] = []

        sut.shouldReloadData = {
            reloadingDataHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)
        sut.searchText = "ETH"

        XCTAssertEqual(reloadingDataHandlers.count, 1)
    }

    func testSearchingReloadingDataHandlingMultipleTimes() {
        let sut = makeSut()
        var reloadingDataHandlers: [(() -> Void)?] = []

        sut.shouldReloadData = {
            reloadingDataHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)

        sut.searchText = "E"
        sut.searchText = "T"
        sut.searchText = "H"

        XCTAssertEqual(reloadingDataHandlers.count, 3)
    }

    func testCryptoListCalledOnlyOnceImediatelly() {
        let sut = makeSut()
        var successHandlers: [(() -> Void)?] = []

        sut.handleSuccess = {
            successHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(successHandlers.count, 1)
    }

    func testCryptoListServerStarted() {
        let sut = makeSut()
        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertNotNil(sut.refreshTimer)
    }

    func testCryptoListServerStopped() {
        let sut = makeSut()
        sut.getCryptoList(isBackgroundFetch: false)
        sut.stopServerCryptoList()

        XCTAssertNil(sut.refreshTimer)
    }

    func testCryptoListCalledAgainWhenServerStart() {
        let sut = makeSut()
        var successHandlers: [(() -> Void)?] = []
        let expectation = expectation(description: "Waiting Timer Fire!")
        let timeInterval = ListViewModel.Constants.timeIntervalFetchInSeconds

        sut.handleSuccess = {
            successHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            expectation.fulfill()
            XCTAssertEqual(successHandlers.count, 2)
        }

        wait(for: [expectation], timeout: timeInterval + 1)
    }

    func testHandlingProgressTwiceSuccessStub() {
        let sut = makeSut()
        var shouldProgressShowHandlers: [(() -> Void)?] = []

        sut.shouldProgressShow = { _ in
            shouldProgressShowHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(shouldProgressShowHandlers.count, 2)
    }

    func testServiceFailureFirstTimeCryptosNil() {
        let sut = makeSut(with: ListServicesFailureStub())

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertNil(sut.cryptos)
    }

    func testServiceFailureErrorHandler() {
        let sut = makeSut(with: ListServicesFailureStub())
        var errorHandlers: [(() -> Void)?] = []

        sut.handleError = { _, _ in
            errorHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(errorHandlers.count, 1)
    }

    func testHandlingProgressTwiceFailureStub() {
        let sut = makeSut(with: ListServicesFailureStub())
        var shouldProgressShowHandlers: [(() -> Void)?] = []

        sut.shouldProgressShow = { _ in
            shouldProgressShowHandlers.append({})
        }

        sut.getCryptoList(isBackgroundFetch: false)

        XCTAssertEqual(shouldProgressShowHandlers.count, 2)
    }
}

extension ListViewModelTests {
    func makeSut(with service: ListServicesProtocol = ListServicesSuccessStub(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> ListViewModel {
        let sut = ListViewModel(service: service)

        checkMemoryLeak(for: sut,
                        file: file,
                        line: line)

        return sut
    }
}
