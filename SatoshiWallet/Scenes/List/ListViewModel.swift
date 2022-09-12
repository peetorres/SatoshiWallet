//
//  ListViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation

class ListViewModel {
    // MARK: Constants and Enums
    private enum Constants {
        static var timeIntervalFetchInSeconds: TimeInterval = 5
    }

    // MARK: Properties
    private var refreshTimer: Timer?
    private let service: ListServicesProtocol
    private var assets: [Asset]?
    private var tickers: [Ticker]?

    var mutableAssets: [Asset]? {
        guard !searchText.isEmpty else { return assets }

        return assets?.filter { asset in
            let nameHasText = asset.name.lowercased().contains(searchText.lowercased())
            let symbolHasText = asset.symbol.lowercased().contains(searchText.lowercased())
            return nameHasText || symbolHasText
        }
    }

    var searchText: String = "" {
        didSet {
            self.shouldReloadData?()
        }
    }

    public var handleSuccess: (() -> Void)?
    public var shouldReloadData: (() -> Void)?
    public var handleError: ((Bool, String) -> Void)?
    public var shouldProgressShow: ((Bool) -> Void)?

    // MARK: Initializer
    init(service: ListServicesProtocol = ListServices()) {
        self.service = service
    }

    // MARK: Services
    func serverAssetLists() {
        guard refreshTimer == nil else { return }

        refreshTimer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervalFetchInSeconds,
                                            repeats: true) { [weak self] _ in
            self?.getAssetLists(isBackgroundFetch: true)
        }
        refreshTimer!.fire()
    }

    func stopServerAssetLists() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    func getAssetLists(isBackgroundFetch: Bool) {
        isBackgroundFetch ? nil : shouldProgressShow?(true)

        service.getAssetList { [weak self] response in
            guard let self = self else { return }

            isBackgroundFetch ? nil : self.shouldProgressShow?(false)

            switch response {
            case .success(let model):
                self.assets = model.data
                self.handleSuccess?()
                !isBackgroundFetch ? self.serverAssetLists() : nil
            case .failure(let error):
                self.handleError?(isBackgroundFetch, error.localizedDescription)
            }
        }
    }

    func getTickers() {
        service.getTickerList(tickers: ["ALL"]) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let model):
                self.tickers = model
            case .failure(let error):
                self.handleError?(false, error.localizedDescription)
            }
        }
    }
}
