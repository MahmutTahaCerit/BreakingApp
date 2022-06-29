//
//  ImageFetch.swift
//  BreakingApp
//
//  Created by Mahmut Taha Cerit on 29.06.2022.
//

import Foundation

public func imageFetch(with url: String?, competion: @escaping (Data) -> Void){
    if let urlString = url, let url = URL(string: urlString){
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    competion(data)
                }
            }
        }.resume()
    }
}
