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
        imageFetch(with: articles?.urlToImage) { data in
            self.breakingImageView.image = UIImage(data: data)
        }
    }
    @IBAction func urlButton(_ sender: Any) {
        guard let link = articles?.url else { return }
        if let url = URL(string:link){
            UIApplication.shared.open(url)
        }
    }
    
}
