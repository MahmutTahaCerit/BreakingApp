//
//  EntertainmentTableViewController.swift
//  BreakingApp
//
//  Created by Mahmut Taha Cerit on 29.06.2022.
//

import UIKit

class EntertainmentTableViewController: UITableViewController{
    
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
        dataFetch()
    }
    private func dataFetch(){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&pageSize=100&category=entertainment&apiKey=\(apiKey)")else { return}
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntertainmentCell", for: indexPath) as! EntertainmentTableViewCell
        cell.authorLabel.text = articles?.author
        cell.descriptionLabel.text = articles?.description
        cell.titleLabel.text = articles?.title
        imageFetch(with: articles?.urlToImage) { data in
            cell.urlImageView.image = UIImage(data: data)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTitle = responseFetch?.articles?[indexPath.row]
        performSegue(withIdentifier: "toEntertainmentDetailVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController {
            viewController.articles = selectedTitle
        }
    }
}
