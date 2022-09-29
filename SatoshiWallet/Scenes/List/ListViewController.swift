//
//  ListViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import UIKit
import RxSwift
import RxCocoa

final class ListViewController: BaseViewController {
    // MARK: Properties
    let viewModel: ListViewModel
    var selectedCrypto: PublishSubject<Crypto> = .init()
    private let bag = DisposeBag()

    // MARK: Outlets
    let switchControl = UISwitch()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBackgroundFetchError: UIView!

    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for Crypto"
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()

    // MARK: Actions
    @objc
    func switchDidChange(sender: UISwitch!) {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }

    // MARK: Initializers
    init(viewModel: ListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvents()
        viewModel.getCryptoList()
    }

    // MARK: Methods
    private func setupUI() {
        viewBackgroundFetchError.isHidden = true
        setupTableView()
        setupNavigationBar()
    }

    private func bindEvents() {
        tableView.rx.setDelegate(self).disposed(by: bag)

        viewModel.cryptos
            .bind(to: tableView.rx.items(cellIdentifier: ListCell.identifier,
                                         cellType: ListCell.self)) { [weak self] _, item, cell in
                let shouldAnimateLabels = self?.searchController.isActive == false
                cell.configure(with: item, shouldAnimateLabels: shouldAnimateLabels)
            }.disposed(by: bag)

        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                guard let cryptos = try? self.viewModel.cryptos.value() else { return }
                self.selectedCrypto.onNext(cryptos[indexPath.row])
            }).disposed(by: bag)

        viewModel.isLoading
            .subscribe { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.dismissProgress()
            }.disposed(by: bag)

        viewModel.isShowingError
            .subscribe(onNext: { [weak self] error in
                switch error {
                case .firstFetch:
                    self?.showNetworkError { [weak self] in
                        self?.viewModel.getCryptoList()
                    }
                case .backgroundFetch, .none:
                    self?.viewBackgroundFetchError.isHidden = error == .none
                }
            })
            .disposed(by: bag)

        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: bag)

        viewModel.searchText
            .subscribe(onNext: { print("searchText: \($0)") })
            .disposed(by: bag)
    }

    private func setupTableView() {
        let nib = UINib(nibName: ListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListCell.identifier)
        tableView.rowHeight = ListCell.rowHeight
    }

    private func setupNavigationBar() {
        title = "Satoshi Wallet"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = false
        setupNavigationBarSwitch()
    }

    private func setupNavigationBarSwitch() {
        let isDarkMode = traitCollection.userInterfaceStyle != .light
        switchControl.setOn(isDarkMode, animated: false)
        switchControl.addTarget(self, action: #selector(switchDidChange(sender:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
    }
}

// MARK: Extensions
extension ListViewController: UITableViewDelegate {}
