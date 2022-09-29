//
//  ListViewModel.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import Foundation
import RxSwift

class ListViewModel {
    // MARK: Constants and Enums
    enum ErrorTypes {
        case firstFetch
        case backgroundFetch
        case none
    }

    enum Constants {
        static var cryptoLimit = 200
        static var timeToFetchRequest: Int = 5
        static var timeIntervalFetchInSeconds: TimeInterval = 5
    }

    // MARK: Properties
    private let service: ListServicesProtocol

    var cryptos: BehaviorSubject<[Crypto]> = .init(value: [])
    var bag = DisposeBag()

    var isLoading: PublishSubject<Bool> = .init()
    var isShowingError: PublishSubject<ErrorTypes> = .init()
    var searchText: BehaviorSubject<String> = BehaviorSubject(value: "")

    var mutableCryptos: Observable<[Crypto]> {
        guard let searchText = try? searchText.value(),
              !searchText.isEmpty else { return cryptos.map { $0 } }

        return cryptos.map { cryptos in
            cryptos.filter { crypto in
                let nameHasText = crypto.name.lowercased().contains(searchText.lowercased())
                let symbolHasText = crypto.symbol.lowercased().contains(searchText.lowercased())
                return nameHasText || symbolHasText
            }
        }
    }

    // MARK: Initializer
    init(service: ListServicesProtocol = ListServices()) {
        self.service = service
    }

    // MARK: Services
    func getCryptoList() {
        service.getCryptoList(limit: Constants.cryptoLimit)
            .do(onSubscribed: { [weak self] in self?.isLoading.onNext(true) },
                onDispose: { [weak self] in self?.isLoading.onNext(false) })
                .subscribe(onSuccess: { [weak self] in
                    self?.cryptos.onNext($0)
                    self?.serverCryptoList()
                }, onFailure: { [weak self] _ in self?.isShowingError.onNext(.firstFetch) })
            .disposed(by: bag)
    }

    func serverCryptoList() {
        Observable<Int>.interval(.seconds(Constants.timeToFetchRequest), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in self?.getCryptoListBackground() }
            .disposed(by: bag)
    }

    func getCryptoListBackground() {
        service.getCryptoList(limit: Constants.cryptoLimit)
            .subscribe(onSuccess: { [weak self] in self?.cryptos.onNext($0) },
                       onFailure: { [weak self] _ in self?.isShowingError.onNext(.backgroundFetch) })
            .disposed(by: bag)
    }
}
