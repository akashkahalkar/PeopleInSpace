//
//  ViewController.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var astronauts: [Astronaut] = []
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var updateStatus: UILabel!
    var hasAllCellsAnimated = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    //Mark: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeoples()
        tableview.addSubview(refreshControl)
    }
    
    fileprivate func getPeoples() {
        RequestManager.get {[weak self] (response) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                switch response.result.status {
                case .success:
                    self.astronauts = response.peoples
                    self.tableview.reloadData()
                    self.changeUpdateLabelStatus()
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                case .fail:
                    print("response fail - \(response.result.message ?? "")")
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }
    
    fileprivate func changeUpdateLabelStatus() {
        let dateString = Date().description
        let dateComponent = dateString.components(separatedBy: " ")
        updateStatus.text = "Last Update: \(dateComponent[0]) \(dateComponent[1])"
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getPeoples()
    }
}

//MARK: - Tableview delgate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableview.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as? DetailsTableViewCell)!
        cell.tag = indexPath.row.advanced(by: 1)
        cell.setupCell(with: astronauts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return astronauts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       animateCells(cell, row: indexPath.row)
    }
    
    private func animateCells(_ cell: UITableViewCell, row: Int) {
        if !hasAllCellsAnimated {
            cell.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0.5 * Double(row), options: [.curveEaseIn], animations: {
                cell.alpha = 1
            }, completion: { (_) in
                if row == (self.astronauts.count - 1) {
                    self.hasAllCellsAnimated = true
                }
            })
        }
    }
}

