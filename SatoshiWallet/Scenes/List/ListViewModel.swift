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

    private(set) var listResponseModel: ListResponse?

    public var handleSuccess: (() -> Void)?
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
            switch response {
                case .success(let model):
                    self?.listResponseModel = model
                    self?.handleSuccess?()

                case .failure(let error):
                    self?.handleError?(error.localizedDescription)
            }
        }
    }
}
