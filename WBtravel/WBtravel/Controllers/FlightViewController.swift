//
//  FlightViewController.swift
//  WBtravel
//
//  Created by Olga on 14.08.2023.
//

import UIKit

class FlightViewController: UIViewController {
    
    var flight: Flights!
    
    weak var delegateHeartStatus: FlightsViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "FlightsTableViewCell", bundle: nil), forCellReuseIdentifier: FlightsTableViewCell.identifier)
    }
}

extension FlightViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightsTableViewCell.identifier, for: indexPath) as? FlightsTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell(from: flight)

        cell.pressHeart = { [unowned self] in
            flight.likeStatus = !flight.likeStatus
            cell.heartImage.image = cell.imageColorChange(from: flight)
            delegateHeartStatus?.updateHeart(flight: flight)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

