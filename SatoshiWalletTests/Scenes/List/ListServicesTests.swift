//
//  ListServicesTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 13/09/22.
//

import XCTest
@testable import Moya
@testable import SatoshiWallet

// swiflint: disable: next line_length
/*
Those tests could be disabled because is responsibility of backend to test their services.
However, was needed to implement in entire crucial flow that the real API could change types
 and crash the app, so was needed manually handle toggle on server to disable the feature
 until the manual fix and force update of the app;
Could not be fully ignored this scenario, even it's async and could be Flaky in a codebase.

IMPORTANT NOTE: THOSE TESTS COULD FAIL BASED ON NETWORK SERVICE!
EXAMPLE: TOO MUCH REQUESTS IN SHORT TIME.

TECHNICAL DEBT: Could be improved in the future running server that mock real APIs
 or inject provider into Service mocking the expected result.
Not sure, but could be injected StubClosure into Provider?
*/

class ListServicesIntegrationTests: XCTestCase {
    // MARK: Test Methods
    func testIntegrationCryptoListSuccess() {
        let sut: ListServices = makeSut()
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

    func testIntegrationAssetListSuccess() {
        let sut: ListServices = makeSut()
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
        let sut: ListServices = makeSut()
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
        let sut: ListServices = makeSut()
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
}

extension ListServicesIntegrationTests {
    func makeSut() -> ListServices {
        let sut = ListServices()
        checkMemoryLeak(for: sut)
        return sut
    }
}
