//
//  RSSearchListViewController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa


class RSSearchListViewController: RSViewController<RSSearchListViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    func setSearchText(_ text: String) {
        self.viewModel.setSearchText(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.viewModel.repositories
            .asObservable()
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.tableView.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
}


extension RSSearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositories.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.rsSearchTableViewCellDefault, for: indexPath)!
        
        let datas = self.viewModel.repositories.value
        guard datas.indices.contains(indexPath.row) else {
            return cell
        }
        
        let data = datas[indexPath.row]
        cell.ownerLabel.text = data.owner ?? ""
        cell.titleLabel.text = data.name ?? ""
        cell.descriptionLabel.text = data.description ?? ""
        cell.starLabel.text = data.starCount?.description ?? ""
        
        return cell
    }
}


extension RSSearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RSSearchTableViewCellDefault.getCellHeight(by: "")
    }
}
