//
//  ListingViewController.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {
    
    var list = [Listable]()
    
    private var dataSource = [Listable]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var selectedItems = [Listable]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var listSelectionHandler: GenericClosure<[Listable]?>?
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.separatorStyle = .none
        reload()
    }
    
    @IBAction func buttonActionApply(_ sender: UIButton) {
       dismmissWithListItem(selectedItems)
    }
    
    @IBAction func buttonActionDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

private extension ListingViewController {
    
    func configureView() {
        tableView?.registerNib(ListCell.self)
        reload()
        tableView?.rowHeight = 50
        tableView?.allowsMultipleSelection = true
    }
    
    func reload(searchText: String = "") {
        if searchText.isEmpty {
            dataSource = list
        } else {
            dataSource = list.filter { $0.passesSearch(for: searchText) }
        }
        
        tableView?.reloadData()
    }
    
    func dismmissWithListItem(_ listableItems: [Listable]?) {
        guard let items = listableItems else { return }
        if items.count < 3 {
            Alert.ok("", "selected items should not be less than 3 ")
        } else if items.count > 7 {
            Alert.ok("", "selected items should not be more than 7 ")
        } else {
            dismiss(animated: true) { [weak self] in
                guard let welf = self else { return }
                welf.listSelectionHandler?(welf.selectedItems)
                welf.listSelectionHandler = nil
            }
        }
    }
}


extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListCell.dequeueReusableCell(in: tableView, indexPath: indexPath)
        let item = dataSource[indexPath.row]
        cell.listableItem = item
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItems.append(dataSource[indexPath.row])
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let items = selectedItems as? [City], let dataSource = dataSource as? [City], let index = items.firstIndex(of: dataSource[indexPath.row]) {
                selectedItems.remove(at: index)
            }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        selectedItems.forEach({ (selected) in
            if selected.listName == dataSource[indexPath.row].listName {
                cell.setSelected(true, animated: true)
            }
        })
    }
}


extension ListingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reload(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

