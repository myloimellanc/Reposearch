//
//  RSSearchContainerViewController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa


class RSSearchContainerViewController: RSViewController<RSSearchContainerViewModel> {
    
    private lazy var searchListViewController: RSSearchListViewController = {
        let vc = R.storyboard.search.rsSearchListViewController()!
        return vc
    }()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController(searchResultsController: searchListViewController)
        searchVC.searchBar.placeholder = "Search Repositories"
        searchVC.hidesNavigationBarDuringPresentation = true
        if #available(iOS 13.0, *) {
            searchVC.automaticallyShowsSearchResultsController = true
            searchVC.showsSearchResultsController = true
        }
        
        return searchVC
    }()
    
    override func initView() {
        super.initView()
        
        self.navigationItem.title = "Reposearch"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.searchController = self.searchController
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
    }
}
