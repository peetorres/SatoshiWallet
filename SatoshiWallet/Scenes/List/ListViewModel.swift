//
//  ListViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation

final class ListViewModel {
    // MARK: Properties
    private var refreshTimer: Timer?
    private let service: ListServicesProtocol

    private var assets: [Asset]? {
        didSet {
            handleSuccess?()
        }
    }

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
    func getAssetLists(isBackgroundFetch: Bool) {
        isBackgroundFetch ? nil : shouldProgressShow?(true)
        service.getAssetList { [weak self] response in
            isBackgroundFetch ? nil : self?.shouldProgressShow?(false)
            switch response {
            case .success(let model):
                self?.assets = model.data
            case .failure(let error):
                self?.handleError?(isBackgroundFetch, error.localizedDescription)
            }
        }
    }

    func serverAssetLists() {
        guard refreshTimer == nil else { return }
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            print("Background Request.")
            self?.getAssetLists(isBackgroundFetch: true)
        }
        refreshTimer!.fire()
    }

    func stopServerAssetLists() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
}
