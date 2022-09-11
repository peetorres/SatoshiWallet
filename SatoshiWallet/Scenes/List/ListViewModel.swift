//
//  ListViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation

final class ListViewModel {
    // MARK: Properties
    private let service: ListServicesProtocol

    private var assets: [Asset]? {
        didSet {
            handleSuccess?()
        }
    }

    var mutableAssets: [Asset]? {
        guard !searchText.isEmpty else { return assets }
        return assets?.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    var searchText: String = "" {
        didSet {
            self.shouldReloadData?()
        }
    }

    public var handleSuccess: (() -> Void)?
    public var shouldReloadData: (() -> Void)?
    public var handleError: ((String) -> Void)?
    public var shouldProgressShow: ((Bool) -> Void)?

    // MARK: Initializer
    init(service: ListServicesProtocol = ListServices()) {
        self.service = service
    }

    // MARK: Services
    func getAssetLists() {
        shouldProgressShow?(true)
        service.getAssetList { [weak self] response in
            self?.shouldProgressShow?(false)
            switch response {
            case .success(let model):
                self?.assets = model.data
            case .failure(let error):
                self?.handleError?(error.localizedDescription)
            }
        }
    }
}
