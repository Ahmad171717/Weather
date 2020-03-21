//
//  MultiCityViewController.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class MultiCityViewController: BaseViewController {

    var list = [WeatherPresentable]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    @IBOutlet private (set) weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
}

private extension MultiCityViewController {
    func configureView() {
        tableView?.registerNib(WeatherCell.self)
    }
}

extension MultiCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherCell.dequeueReusableCell(in: tableView, indexPath: indexPath)
        cell.item = list[indexPath.row]
        
        return cell
    }
}


