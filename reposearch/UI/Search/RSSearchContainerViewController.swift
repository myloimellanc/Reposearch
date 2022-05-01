//
//  RSSearchContainerViewController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa


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
            // TODO: iPhone SE 1세대에서만 말줄임 처리됨
            return "Updated"
        }
    }
}


class RSSearchContainerViewController: RSViewController<RSSearchContainerViewModel> {
    
    @IBOutlet weak var perPageLabel: UILabel!
    @IBOutlet weak var perPageSegmentedControl: UISegmentedControl!
    
    private lazy var searchListViewController: RSSearchListViewController = {
        let vc = R.storyboard.search.rsSearchListViewController()!
        vc.delegate = self
        
        return vc
    }()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController(searchResultsController: searchListViewController)
        searchVC.searchBar.tintColor = R.color.accentColor()
        
        if #available(iOS 13.0, *) {
            searchVC.searchBar.searchTextField.defaultTextAttributes = .Body1
            searchVC.searchBar.searchTextField.typingAttributes = .Body1
            searchVC.searchBar.searchTextField.attributedPlaceholder = .Body1(R.string.localizable.searchSearchBarPlaceholder(),
                                                                              with: [.foregroundColor: R.color.textLightGrey() as Any])
            
        } else {
            searchVC.searchBar.placeholder = R.string.localizable.searchSearchBarPlaceholder()
        }
        
        searchVC.searchBar.setValue(R.string.localizable.searchCancelButtonTitle(), forKey: "cancelButtonText")
        
        searchVC.hidesNavigationBarDuringPresentation = true
        if #available(iOS 13.0, *) {
            searchVC.automaticallyShowsSearchResultsController = true
            searchVC.showsSearchResultsController = true
        }
        
        searchVC.searchBar.scopeButtonTitles = self.viewModel.searchSorts.map { $0.titleValue }
        searchVC.searchBar.rx.selectedScopeButtonIndex
            .asObservable()
            .startWith(0)
            .withUnretained(self)
            .subscribe(onNext: { vc, index in
                let sort = vc.viewModel.searchSorts[index]
                vc.searchListViewController.setSearchSort(sort)
            })
            .disposed(by: self.disposeBag)
        
        searchVC.rx.willDismiss
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.searchListViewController.setSearchText("")
            })
            .disposed(by: self.disposeBag)
        
        return searchVC
    }()
    
    override func initView() {
        super.initView()
        
        self.navigationItem.title = R.string.localizable.title()
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.searchController = self.searchController
        
        self.perPageLabel.attributedText = .Body1(R.string.localizable.searchPerPageTitle())
        self.perPageSegmentedControl.setTitleTextAttributes(.Body2, for: .normal)
        self.perPageSegmentedControl.setTitleTextAttributes(.Body2, for: .selected)
        
        self.viewModel.perPages
            .enumerated()
            .forEach { self.perPageSegmentedControl.setTitle($1.description, forSegmentAt: $0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchBar.rx.text
            .asObservable()
            .map { $0 ?? "" }
            .withUnretained(self)
            .subscribe(onNext: { vc, text in
                vc.searchListViewController.setSearchText(text)
            })
            .disposed(by: self.disposeBag)
        
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
