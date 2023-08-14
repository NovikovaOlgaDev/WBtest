//
//  FlightsViewController.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//
import Foundation
import UIKit

protocol FlightsViewControllerDelegate: AnyObject {
    func updateHeart(flight: Flights)
}

class FlightsViewController: UIViewController, FlightsViewControllerDelegate {
    
    let networkManager = NetworkingManager.shared
    
    var flights: [Flights] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true

        tableView.register(UINib(nibName: "FlightsTableViewCell", bundle: nil), forCellReuseIdentifier: FlightsTableViewCell.identifier)
        
        //MARK: - network manager
        networkManager.request(activityIndicator: activityIndicator, completion: { [weak self] result in
            switch result {
            case .success(let result):
                let dateFormatter = DateFormatterManager.shared
                var f = result.flights.map {
  
                    Flights(searchToken: $0.searchToken,
                            startCity: $0.startCity,
                            endCity: $0.endCity,
                            price: $0.price,
                            startDate: dateFormatter.dateFormatterStringToDate(from: $0.startDate),
                            endDate: dateFormatter.dateFormatterStringToDate(from: $0.endDate),
                            startIATA: $0.startLocationCode,
                            endIATA: $0.endLocationCode,
                            likeStatus: false)
                }
           
                f.sort(by:  {$0.startDate < $1.startDate })
    
                print("f.count \(f.count)")
                self!.flights = f
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("error:", error)
            }
        })
    }
}

extension FlightsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightsTableViewCell.identifier, for: indexPath) as? FlightsTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell(from: flights[indexPath.row])

        cell.pressHeart = { [unowned self] in
            flights[indexPath.row].likeStatus = !flights[indexPath.row].likeStatus
            cell.heartImage.image = cell.imageColorChange(from: flights[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailFlight", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! FlightViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.flight = flights[indexPath.row]
        }
        destinationVC.delegateHeartStatus = self
    }
    
    func updateHeart(flight: Flights) {
        print(flight.likeStatus)
        
        if let index = tableView.indexPathForSelectedRow {
            flights[index.row].likeStatus = flight.likeStatus
            tableView.reloadData()
        }
    }
}


