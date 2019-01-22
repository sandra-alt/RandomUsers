//
//  ContactInfoCell.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/22/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

enum ContactType: String {
    case phone = "phone"
    case cellPhone = "cell_phone"
    case email = "email"
}

class ContactInfoCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var contactButton: UIButton!
    var delegate: ReachOutDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCellFor(info: String, type: ContactType) {
        contactButton.setTitle(info, for: .normal)
        if type != .email {
            contactButton.addTarget(self, action: #selector(reachOut), for: .touchDown)
        }
        iconView.image = UIImage(named: type.rawValue)
    }
    
    @objc private func reachOut() {        
        delegate?.callNumber(phoneNumber: contactButton.currentTitle!)
    }
}
