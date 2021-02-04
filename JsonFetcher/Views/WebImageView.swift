//
//  WebImageView.swift
//  JsonFetcher
//
//  Created by Денис on 04.02.2021.
//

import UIKit

class WebImageView: UIImageView {
    
    private var indicator = LoadingIndicator()
    
    func set(imageURL: String?) {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
        
        // Check cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        indicator.show(for: self)
        // Load if cache is empty
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self.image = UIImage(data: data)
                    self.handleLoadedImage(data: data, response: response)
                    self.indicator.hideAfter(deadline: .now() + 1)
                }
            }
        }
        dataTask.resume()
    }
    
    // Image caching
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse.init(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
