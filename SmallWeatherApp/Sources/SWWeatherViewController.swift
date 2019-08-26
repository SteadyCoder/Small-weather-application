//
//  SWWeatherViewController.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

class SWWeatherViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SWRequestManager.shared.getWeather(withCityName: "Kiev") { (success, error) in
            print("done")
        }
    }

}

extension SWWeatherViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SWWeatherTableViewCell.tableCellIdentifier, for: indexPath) as! SWWeatherTableViewCell
        
        cell.cityLabel.text = "Kyiv, UA"
        cell.cityWeatherDescription.text = "Sunny"
        cell.weatherTempreture.text = "15º"
        cell.weatherImage.backgroundColor = .yellow
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
}

