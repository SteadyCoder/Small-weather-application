//
//  SWWeatherViewController.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

class SWWeatherViewController: UITableViewController {
    let viewModel = SWWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCitiesData {
            print("city data loaded")
        }
    }

}

extension SWWeatherViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listOfCitiesName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SWWeatherTableViewCell.tableCellIdentifier, for: indexPath) as! SWWeatherTableViewCell
        let row = indexPath.row
        
        cell.cityLabel.text = self.viewModel.listOfCitiesName[row]
        cell.cityWeatherDescription.text = "Sunny"
        cell.weatherTempreture.text = "15º"
        cell.weatherImage.backgroundColor = .yellow
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
}

