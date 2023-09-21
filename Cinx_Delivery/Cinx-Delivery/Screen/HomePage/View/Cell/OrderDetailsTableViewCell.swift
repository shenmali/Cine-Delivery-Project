//
//  OrderDetailsTableViewCell.swift
//  Cinx-Delivery
//
//  Created by Ali on 19/09/2023.
//  Order Detail Cell

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var contenxtview: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var referenceNumber: UILabel!
    @IBOutlet weak var orderDetailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    private func setupUI() {
        contenxtview.layer.shadowColor = UIColor.black.cgColor
        contenxtview.layer.shadowOpacity = 0.5
        contenxtview.layer.shadowOffset = CGSize(width: 0, height: 3)
        contenxtview.layer.shadowRadius = 5
    }
    func setupCell(_ model: DeliveryBill) {
        dateLabel.text = model.BILL_DATE
        referenceNumber.text = "#\(model.BILL_SRL ?? "0")"
        let tAX_AMT = (model.TAX_AMT ?? "0")
        let bILL_AMT = (model.BILL_AMT ?? "0")
        let priceDouble = (Double(tAX_AMT) ?? 0) + (Double(bILL_AMT) ?? 0)
        let priceInt = Int(priceDouble)
        totalPriceLabel.text = "\(priceInt) LE"
        switch model.DLVRY_STATUS_FLG {
        case "1":
            ChangeTitleAndColor(title: "Delivering", color: "#004F62")
        case "2":
            ChangeTitleAndColor(title: "Returned", color: "#D42A0F")
        case "3":
            ChangeTitleAndColor(title: "Pending", color: "#707070")
        default:
            ChangeTitleAndColor(title: "New", color: "#29D40F")
        }
        
        func ChangeTitleAndColor(title: String, color : String) {
            statusLabel.text = title
            buttonView.backgroundColor = UIColor(named: color) ?? .red
            statusLabel.textColor = UIColor(named: color) ?? .red
        }
    }
}
