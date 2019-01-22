//
//  UserPictureCell.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/22/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

class UserPictureCell: UITableViewCell {

    @IBOutlet weak var userPictureView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellFor(user: User) {
        setProfPicture(withURL: URL(string: user.picture.imgURLString))
        
        nameLabel.text = "\(user.name.first) \(user.name.last)".capitalized
        locationLabel.text = "\(user.location.city), \(user.location.state)".capitalized
        genderLabel.text = "\(user.gender) "
        
        let formattedDate = dateFormatter.date(from: dateFormatter.string(from: user.dateOfBirth.date))
        birthDayLabel.text = " \(shortDateFormatter.string(from: formattedDate!)) "

        ageLabel.text = " \(user.dateOfBirth.age) "
    }
    
    //MARK: - Picture
    
    fileprivate func setProfPicture(withURL url: URL?) {
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("Can't load an image")
                return
            }
            DispatchQueue.main.async {
                self.userPictureView?.image = UIImage(data:data)
            }
        }.resume()
    }
    
    //MARK: - DateFormatters
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return df
    }
    
    private var shortDateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        return df
    }
}
