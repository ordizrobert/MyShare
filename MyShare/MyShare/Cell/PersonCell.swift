//
//  PersonCell.swift
//  MyShare
//
//  Created by robert ordiz on 4/19/23.
//

import UIKit
import Foundation

class PersonCell: UITableViewCell {
    lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Person"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return nameLabel
    }()
    
    lazy var shareLabel:UILabel = {
        let shareLabel = UILabel()
        shareLabel.text = "$-"
        shareLabel.textColor = .white
        shareLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return shareLabel
    }()
    
    var totalShare: String! = "" {
        didSet {
            shareLabel.text = totalShare
        }
    }
    
    var data: EachShareData! = nil {
        didSet {
            nameLabel.text = data.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        backgroundColor = .clear
        tintColor = .white
        setupUI()
    }
    
    class func cellReuseID() -> String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "personImage")
        
        addSubview(logoImage)
        logoImage.anchor(left: leftAnchor, paddingLeft: 15, width: 30,height: 30)
        logoImage.centerY(inView: self)
        
        addSubview(shareLabel)
        shareLabel.anchor(left: centerXAnchor, right: rightAnchor, paddingLeft: 40, paddingRight: 40, height: 30)
        shareLabel.centerY(inView: self)
        
        nameLabel.text = "Person \(tag)"
        addSubview(nameLabel)
        nameLabel.anchor(left: leftAnchor, right: shareLabel.leftAnchor, paddingLeft: 60,height: 30)
        nameLabel.centerY(inView: self)
    }
}

class ItemCell: UITableViewCell {
    lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = ""
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return nameLabel
    }()
    
    lazy var shareLabel:UILabel = {
        let shareLabel = UILabel()
        shareLabel.text = "$-"
        shareLabel.textColor = .white
        shareLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return shareLabel
    }()
    
    var data: Items! = nil {
        didSet {
            let twoDecimalPlaces = String(format: "%.2f",  data.price!)
            nameLabel.text = data.item
            shareLabel.text = "$\(twoDecimalPlaces)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        backgroundColor = .clear
        tintColor = .white
        setupUI()
    }
    
    class func cellReuseID() -> String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "itemIcon")
        
        addSubview(logoImage)
        logoImage.anchor(left: leftAnchor, paddingLeft: 15, width: 30,height: 30)
        logoImage.centerY(inView: self)
        
        addSubview(shareLabel)
        shareLabel.anchor(left: centerXAnchor, right: rightAnchor, paddingLeft: 40, paddingRight: 40, height: 30)
        shareLabel.centerY(inView: self)
        
        addSubview(nameLabel)
        nameLabel.anchor(left: leftAnchor, right: shareLabel.leftAnchor, paddingLeft: 60,height: 30)
        nameLabel.centerY(inView: self)
    }
}
