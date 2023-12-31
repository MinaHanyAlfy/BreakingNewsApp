//
//  UIImageView+Extension.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-11.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    /// For Download The Image From URL
    /// - Parameter url: Image Link
    func fromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    /// To Download And check If Image Cache in Application File
    /// - Parameters:
    ///   - URLString: Image Link
    ///   - placeHolder: Image For No Response or Wrong Response
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        if URLString == "" {
            self.image = placeHolder
            return
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        self?.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                      imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self?.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
