//
//  UserListCell.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/22/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    private var isIPhoneSE: Bool {
        return UIScreen.main.nativeBounds.height == 1136
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellFor(user: User) {
        nameLabel.text = "\(user.name.first) \(user.name.last)".capitalized
        locationLabel.text = "\(user.location.city), \(user.location.state)".capitalized
        if isIPhoneSE {
            locationLabel.font = locationLabel.font.withSize(9)
        }
        genderLabel.text = (user.gender == "male") ? "\u{2642}" : "\u{2640}"
        
        imageURL = URL(string: user.picture.thumbURLString)
        setProfPicture()
    }
    
    //MARK: - Image loading
    
    fileprivate func setProfPicture() {
        profileImgView?.image = nil
        if let imageFromCache = imageCache.object(forKey: imageURL as AnyObject){
            profileImgView?.image = imageFromCache
            return
        } else {
            loadImage(withURL: imageURL) { (image) in
                self.profileImgView?.image = image
            }
        }
    }
    
    fileprivate let imageCache = NSCache<AnyObject, UIImage>()
    fileprivate var imageURL: URL?
    
    fileprivate func loadImage(withURL url: URL?, completionHandler: @escaping(UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("Can't load an image")
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data:data)
                self.imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                if self.imageURL == url {
                    completionHandler(imageToCache)
                }
            }
        }.resume()
    }
}
