//
//  FlightsTableViewCell.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {
    
    static let identifier = "FlightsTableViewCell"
    
    var pressHeart: (() -> Void)?
    
    @IBOutlet weak var carpetView: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var startCityEndCity: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startIATA: UILabel!
    @IBOutlet weak var endIATA: UILabel!
    
    @IBOutlet weak var stackView1: UIView!
    @IBOutlet weak var stackView2: UIView!
    
    @IBOutlet weak var calendarTop: UILabel!
    @IBOutlet weak var calendarBottom: UILabel!
    
    
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBAction func heartButtonTap(_ sender: Any) {
        pressHeart?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appereanceOfElements()
    }
    
    func configureCell(from flight: Flights) {
        let dateFormatter = DateFormatterManager.shared
        let intFormatter = IntFormatterManager.shared
        
        let sC = flight.startCity
        let eC = flight.endCity
        
       startCityEndCity.text = "\(sC) - \(eC)"
        startTime.text =  dateFormatter.dateFormatterDateToString(from: flight.startDate, format: "hh : mm")
        endTime.text = dateFormatter.dateFormatterDateToString(from: flight.endDate, format: "hh : mm")
        startDate.text =  dateFormatter.dateFormatterDateToString(from: flight.startDate, format: "EEE, d  MMM")
        endDate.text = dateFormatter.dateFormatterDateToString(from: flight.endDate, format: "EEE, d  MMM")
        startIATA.text = flight.startIATA
        endIATA.text = flight.endIATA
        
        calendarTop.text = dateFormatter.dateFormatterDateToString(from: flight.startDate, format: "MMM")
        calendarBottom.text = dateFormatter.dateFormatterDateToString(from: flight.startDate, format: "d")
        
        let p = intFormatter.intFotmatterForPrice(from: (flight.price))
        price.text = "\(p) р"
        
        heartImage.image = imageColorChange(from: flight)
    }
    
    func imageColorChange(from flight: Flights) -> UIImage {
        var image: UIImage!

        if flight.likeStatus {
            image = UIImage(named: "heartColor")!
        } else {
            image = UIImage(named: "heart")!
        }
        return image
    }

    private func appereanceOfElements() {
        stackView1.layer.borderColor = UIColor.black.cgColor
        stackView1.layer.borderWidth = 0.3
        stackView1.layer.cornerRadius = stackView1.frame.size.height / 4
        stackView1.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        stackView2.layer.borderColor = UIColor.black.cgColor
        stackView2.layer.borderWidth = 0.3
        stackView2.layer.cornerRadius = stackView1.frame.size.height / 4
        stackView2.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        carpetView.layer.borderColor = UIColor.black.cgColor
        carpetView.layer.borderWidth = 0.3
        carpetView.layer.cornerRadius = 6
    }
}
