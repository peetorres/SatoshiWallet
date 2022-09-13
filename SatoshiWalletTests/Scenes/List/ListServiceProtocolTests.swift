//
//  ListServiceProtocolTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import SatoshiWallet

class ListServicesProtocolTests: XCTestCase {
    // MARK: Properties
    var sut: ListServicesProtocol!

    // MARK: Setup
    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    // MARK: Test Methods
    func testIntegrationCryptoListSuccess() {
        sut = ListServicesSuccessStub()
        let exp = expectation(description: "waiting")
        sut.getCryptoList(limit: 10) { result in
            switch result {
            case .success(let cryptos):
                XCTAssertNotNil(cryptos)
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }

    func testIntegrationCryptoListEmpty() {
        sut = ListServicesEmptySuccessStub()
        let exp = expectation(description: "waiting")
        sut.getCryptoList(limit: 10) { result in
            switch result {
            case .success(let cryptos):
                XCTAssertEqual(cryptos.count, 0)
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }

    func testIntegrationAssetListSuccess() {
        sut = ListServicesSuccessStub()
        let exp = expectation(description: "waiting")
        sut.getAssetList(limit: 10) { result in
            switch result {
            case .success(let assetList):
                XCTAssertNotNil(assetList.data)
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }

    func testIntegrationTickerAssetFailLimitNegative() {
        sut = ListServicesFailureStub()
        let exp = expectation(description: "waiting")
        sut.getAssetList(limit: -10) { result in
            switch result {
            case .success:
                XCTFail("Should Fail!")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }

    func testIntegrationTickerListSuccess() {
        sut = ListServicesSuccessStub()
        let searchTickers = ["tBTCUSD", "tETHUSD", "tCHSB:USD"]
        let exp = expectation(description: "waiting")
        sut.getTickerList(tickers: searchTickers) { result in
            switch result {
            case .success(let tickers):
                XCTAssertNotNil(tickers)
            case .failure(let error):
                XCTFail("\(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }

    func testIntegrationTickerListFailWrongTicker() {
        sut = ListServicesFailureStub()
        let searchTickers = ["tBITCOINUSD"]
        let exp = expectation(description: "waiting")
        sut.getTickerList(tickers: searchTickers) { result in
            switch result {
            case .success:
                XCTFail("Should Fail!")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }
}
