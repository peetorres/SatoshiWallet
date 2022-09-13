//
//  ListViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation

class ListViewModel {
    // MARK: Constants and Enums
    enum Constants {
        static var cryptoLimit = 200
        static var timeIntervalFetchInSeconds: TimeInterval = 5
    }

    // MARK: Properties
    private(set) var refreshTimer: Timer?
    private let service: ListServicesProtocol

    private(set) var cryptos: [Crypto]?
    var mutableCryptos: [Crypto]? {
        guard !searchText.isEmpty else { return cryptos }
        return cryptos?.filter { crypto in
            let nameHasText = crypto.name.lowercased().contains(searchText.lowercased())
            let symbolHasText = crypto.symbol.lowercased().contains(searchText.lowercased())
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

    deinit {
        stopServerCryptoList()
    }

    // MARK: Services
    func serverCryptoList() {
        guard refreshTimer == nil else { return }

        let dispatchTime: DispatchTime = .now() + Constants.timeIntervalFetchInSeconds
        refreshTimer = Timer.scheduledTimer(withTimeInterval: .nan, repeats: false, block: { _ in })

        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [weak self] in
            self?.refreshTimer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervalFetchInSeconds,
                                                      repeats: true) { [weak self] _ in
                self?.getCryptoList(isBackgroundFetch: true)
            }
            self?.refreshTimer!.fire()
        }
    }

    func stopServerCryptoList() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    func getCryptoList(isBackgroundFetch: Bool) {
        isBackgroundFetch ? nil : shouldProgressShow?(true)

        service.getCryptoList(limit: Constants.cryptoLimit) { [weak self] response in
            guard let self = self else { return }
            isBackgroundFetch ? nil : self.shouldProgressShow?(false)

            switch response {
            case .success(let model):
                self.cryptos = model
                self.handleSuccess?()
                self.serverCryptoList()
            case .failure(let error):
                self.handleError?(isBackgroundFetch, error.localizedDescription)
            }
        }
    }
}
