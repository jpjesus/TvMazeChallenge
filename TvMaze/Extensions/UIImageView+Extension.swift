//
//  UIImageView+Extension.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import UIKit


extension UIImageView {
    
    var imageCache: NSCache<NSString, UIImage> {
        get { return NSCache<NSString, UIImage>() }
    }
    
    func loadImage(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let loaderColor = UIActivityIndicatorView(style: .medium)
        let activityIndicator: UIActivityIndicatorView = loaderColor
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let data = data,
               let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
