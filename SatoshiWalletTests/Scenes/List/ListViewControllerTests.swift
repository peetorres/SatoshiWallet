//
//  ListViewControllerTests.swift
//  SatoshiWalletTests
//
//  Created by Pedro Gabriel on 08/09/22.
//

import XCTest
@testable import SatoshiWallet

class NavigationControllerSpy: UINavigationController {
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}

class ListViewControllerTests: XCTestCase {
    // MARK: Properties
    var sut: ListViewController!

    // MARK: Setup
    override func setUpWithError() throws {
        try? super.setUpWithError()
        sut = ListViewController()
        _ = sut.view
    }

    // MARK: Test Controller Behaviors
    func testInitWithCoder() {
        testInitWithCoder(of: sut)
    }

    // MARK: Test Screen Elements
    func testNavigationTitle() {
        XCTAssertEqual(sut.title, "Satoshi Wallet")
    }

    // MARK: Test UseCases
    func testHandleSuccess() {
        sut = ListViewController(viewModel: .init(service: ListServicesSuccessStub()))
        _ = sut.view

        let navigationControllerSpy = NavigationControllerSpy(rootViewController: sut)

        sut.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)

        guard navigationControllerSpy.pushedViewController is DetailsViewController else {
            let nameOfScene: String = navigationControllerSpy.pushedViewController?.description ?? ""
            XCTFail("Not instanced DetailsViewController, instanced \(nameOfScene) instead")
            return
        }
    }
}

class ListServicesSuccessStub: ListServicesProtocol {
    func getAssetList(completion: @escaping ((Result<ListResponse, NetworkLayerError>) -> Void)) {
        let response: ListResponse = .init(data: [makeAsset(), makeAsset(), makeAsset()], timestamp: 123)
        completion(.success(response))
    }

    func makeAsset() -> Asset {
        .init(id: "bitcoin",
              rank: "1",
              symbol: "BTC",
              name: "Bitcoin",
              supply: "21",
              maxSupply: "21",
              marketCapUsd: "123",
              volumeUsd24Hr: "12",
              priceUsd: "123456",
              changePercent24Hr: "1",
              explorer: "asd.info")
    }
}
