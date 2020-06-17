//
//  ViewController.swift
//  VestiRu
//
//  Created by Marina Svistkova on 10.06.2020.
//  Copyright © 2020 Marina Svistkova. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var rssItems: [RSSItem]?
    private var filteredItems = [RSSItem]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func pageRefreshControl(_ sender: UIRefreshControl) {
        fetchData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableView.automaticDimension
        fetchData()
        searchBar.placeholder = "Поиск по категориям:"
    }
    
    func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://www.vesti.ru/vesti.rss") { (rssItems) in
            self.rssItems = rssItems
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rssItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .none
        cell.dateLabel.text = rssItems?[indexPath.item].pubDate
        cell.titleLabel.text = rssItems?[indexPath.item].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToArticle", sender: self )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            (segue.destination as? ArticleViewController)?.article = rssItems?[indexPath.row]
        }
    }
}



