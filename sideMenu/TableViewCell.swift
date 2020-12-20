//
//  TableViewCell.swift
//  sideMenu
//
//  Created by Mahdie Ghasemi on 12/20/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    var icon = UIImageView()
    var label = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 35).isActive = true
        
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = . white
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: icon.leftAnchor,constant: 35).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
