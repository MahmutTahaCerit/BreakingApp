//
//  BreakingTableViewController.swift
//  BreakingApp
//
//  Created by Mahmut Taha Cerit on 26.06.2022.
//

import UIKit

class BreakingTableViewController: UITableViewController{
    private var responseFetch: BreakingModel?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var selectedTitle: Articles?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Son Dakika Haberler"
        dataFetch()
    }
    private func dataFetch(){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&pageSize=100&apiKey=\(apiKey)")else { return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data, let response = try? JSONDecoder().decode(BreakingModel.self, from: data){
                self.responseFetch = response
            }
        }.resume()
    }
    private func imageFetch(with url: String?, competion: @escaping (Data) -> Void){
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return responseFetch?.articles?.count ?? .zero
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articles = responseFetch?.articles?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BreakingTableViewCell
        cell.authorLabel.text = articles?.author
        cell.descriptionLabel.text = articles?.description
        cell.titleLabel.text = articles?.title
        imageFetch(with: articles?.urlToImage) { data in
            cell.breakingImageView.image = UIImage(data: data)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTitle = responseFetch?.articles?[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? DetailViewController {
            viewController.articles = selectedTitle
        }
    }
}
