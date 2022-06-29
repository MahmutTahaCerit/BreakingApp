//
//  DetailViewController.swift
//  BreakingApp
//
//  Created by Mahmut Taha Cerit on 26.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var breakingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    var articles: Articles?
    override func viewDidLoad() {
        super.viewDidLoad()
        authorLabel.text = articles?.author
        descriptionLabel.text = articles?.description
        titleLabel.text = articles?.title
        görselAl(with: articles?.urlToImage) { data in
            self.breakingImageView.image = UIImage(data: data)
        }
    }
    @IBAction func urlButton(_ sender: Any) {
        
    }
    private func görselAl(with url: String?, competion: @escaping (Data) -> Void){
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
}
