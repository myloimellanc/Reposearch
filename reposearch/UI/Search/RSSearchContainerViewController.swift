//
//  RSSearchContainerViewController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa
import DeviceKit


fileprivate extension RSSearchSort {
    var titleValue: String {
        switch self {
        case .bestMatch:
            return "Best"
        case .stars:
            return "Stars"
        case .forks:
            return "Forks"
        case .helpWantedIssues:
            return "Issues"
            
        case .updated:
            switch Device.current {
            case .iPhoneSE:
                return "Update"
                
            #if targetEnvironment(simulator)
            case .simulator(.iPhoneSE):
                return "Update"
            #endif
                
            default:
                return "Updated"
            }
        }
    }
}


class RSSearchContainerViewController: RSViewController<RSSearchContainerViewModel> {
    
    @IBOutlet weak var perPageLabel: UILabel!
    @IBOutlet weak var perPageSegmentedControl: UISegmentedControl!
    
    private let searchListViewController: RSSearchListViewController = {
        let searchListVC = R.storyboard.search.rsSearchListViewController()!
        return searchListVC
    }()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController(searchResultsController: self.searchListViewController)
        return searchVC
    }()
    
    override func initView() {
        super.initView()
        
        self.navigationItem.title = R.string.localizable.title()
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.searchController = self.searchController
        
        self.searchController.searchBar.tintColor = R.color.accentColor()
        self.searchController.searchBar.placeholder = R.string.localizable.searchSearchBarPlaceholder()
        self.searchController.searchBar.setValue(R.string.localizable.searchCancelButtonTitle(), forKey: "cancelButtonText")
        
        self.perPageLabel.attributedText = .Body1(R.string.localizable.searchPerPageTitle())
        
        self.perPageSegmentedControl.setTitleTextAttributes(.Body2, for: .normal)
        self.perPageSegmentedControl.setTitleTextAttributes(.Body2, for: .selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSearchController()
        self.initPerPageSegmentControl()
    }
    
    private func initSearchController() {
        self.searchListViewController.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = true
        if #available(iOS 13.0, *) {
            self.searchController.automaticallyShowsSearchResultsController = true
            self.searchController.showsSearchResultsController = true
        }
        
        self.searchController.searchBar.rx.text
            .asObservable()
            .map { $0 ?? "" }
            .withUnretained(self)
            .subscribe(onNext: { vc, text in
                vc.searchListViewController.setSearchText(text)
            })
            .disposed(by: self.disposeBag)
        
        self.searchController.searchBar.scopeButtonTitles = self.viewModel.searchSorts.map { $0.titleValue }
        
        self.searchController.searchBar.rx.selectedScopeButtonIndex
            .asObservable()
            .startWith(0)
            .withUnretained(self)
            .subscribe(onNext: { vc, index in
                let sort = vc.viewModel.searchSorts[index]
                vc.searchListViewController.setSearchSort(sort)
            })
            .disposed(by: self.disposeBag)
        
        self.searchController.rx.willDismiss
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.searchListViewController.setSearchText("")
            })
            .disposed(by: self.disposeBag)
    }
    
    private func initPerPageSegmentControl() {
        self.viewModel.perPages
            .enumerated()
            .forEach { self.perPageSegmentedControl.setTitle($1.description, forSegmentAt: $0) }
        
        self.perPageSegmentedControl.rx.selectedSegmentIndex
            .asObservable()
            .startWith(0)
            .withUnretained(self)
            .subscribe(onNext: { vc, index in
                let perPage = vc.viewModel.perPages[index]
                vc.searchListViewController.setPerPage(perPage)
            })
            .disposed(by: self.disposeBag)
    }
}


extension RSSearchContainerViewController: RSSearchListViewControllerDelegate {
    func listDidScroll(from viewController: RSSearchListViewController, tableView: UITableView) {
        if self.searchController.searchBar.isFirstResponder {
            self.searchController.searchBar.resignFirstResponder()
        }
    }
}
