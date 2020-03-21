//
//  CurrentCityViewController.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class CurrentCityViewController: BaseViewController {
    
    var sections = [Section]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var list: [WeatherPresentable]?
    
    @IBOutlet private (set) weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

private extension CurrentCityViewController {
    func configureView() {
        tableView?.registerNib(WeatherCell.self)
        getSections()
    }
    
    func getTheFiveNextDays() -> [String] {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponent = DateComponents()
        var weekDaysName = [String]()
        
        for weekDay in 1...5 {
            
            // get the five week days name from current date
            dateComponent.day = weekDay
            guard let newDate = calendar.date(byAdding: dateComponent, to: Date(), wrappingComponents: true) else { return [] }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            weekDaysName.append(dateFormatter.string(from: newDate))
        }
        
        return weekDaysName
    }
    
    func getSections() {
        guard var weatherObjects = list else { return }
        let weekDays = getTheFiveNextDays()
        let numberOfWeatherObjectsPerDay = weatherObjects.count / weekDays.count
        var sections = [Section]()
        
        weekDays.forEach { weekDay in
            var objects = [WeatherPresentable]()
            
            for i in 0..<numberOfWeatherObjectsPerDay {
                
                // add weekday weather objects to the array
                objects.append(weatherObjects[i])
            }
                        
            // create section with it's 8 items
            sections.append(Section(title: weekDay, items: objects))
            
            // remove first 8 objects from array which is already added
            weatherObjects = Array(weatherObjects.dropFirst(numberOfWeatherObjectsPerDay))
        }
        
        // update sections
        self.sections = sections
    }
}

extension CurrentCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherCell.dequeueReusableCell(in: tableView, indexPath: indexPath)
        cell.item = sections[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = WeatherHeaderView.instantiateFromNib() as? WeatherHeaderView else { return nil }
        sectionView.title = sections[section].title
        
        return sectionView
    }
}

extension CurrentCityViewController {
    class Section {
        var title: String
        var items: [WeatherPresentable]
        
        init(title: String, items: [WeatherPresentable]) {
            self.title = title
            self.items = items
        }
    }
}

