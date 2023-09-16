//
//  ViewController.swift
//  StarWar
//
//  Created by Chathuranga Adikari on 2023-09-14.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    private var starViewModel = StarViewModel()
    private var disposeBag = DisposeBag()
    
    var pageNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStarData()
        bindTableViewData()
    }
    
    func loadStarData () {
        starViewModel.fetchStarDate(page: pageNum)
    }
    
    func bindTableViewData () {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        starViewModel.starArray.bind(to: tableView.rx.items(cellIdentifier: "starCell", cellType: StartCell.self)){ (row,item,cell) in
            cell.nameLbl.text = item.name
            cell.climateLbl.text = item.climate
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let starsDetails = try? starViewModel.starArray.value() else { return}
        
        print(starsDetails[indexPath.row].name!)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailScreen") as? DetailScreen
        vc?.starDetails = starsDetails[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let starsDetails = try? starViewModel.starArray.value() else { return}
        
        if (indexPath.row == starsDetails.count - 1) {
            print("Found End of the page")
            var pageNumIncreased = pageNum + 1
            if (pageNumIncreased <= starViewModel.pageLimit) {
                    pageNum = pageNumIncreased
                    starViewModel.fetchStarDate(page: pageNum)

            } else {
                print("Page limit reached")
            }
            
        }
    }
}

class StartCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    
}

