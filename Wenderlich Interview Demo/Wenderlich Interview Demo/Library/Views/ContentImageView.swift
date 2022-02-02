//
//  ContentImageView.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 2/1/22.
//

import UIKit

class ContentImageView: UIImageView {
    
    let placeholder = UIImage(named: "temp")
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImage() {
        layer.cornerRadius = 12
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: URL) {
        let cacheKey = NSString(string: url.absoluteString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [unowned self] data, response, error in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
