//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositorySearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var repositorySearchBar: UISearchBar!
    
    var repository: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String!
    var url: String!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositorySearchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        repositorySearchBar.delegate = self
    }
    
    //編集の可否を定義
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    //テキストが変更されるたびに呼び出される。
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        word = searchBar.text!
        
        if word.count != 0 {
            url = "https://api.github.com/search/repositories?q=\(word!)"
            guard let theUrl = URL(string: url) else {
                print("bad URL string")
                return
            }
            task = URLSession.shared.dataTask(with: theUrl) { (data, res, err) in
                do {
                    if let error = err {
                        throw error
                    }
                    guard let jsonData = data else {
                        print("data is nil")
                        throw error.dataNil
                    }
                    guard let obj = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                        print("JSON Serialization failed")
                        throw error.badData
                    }
                    guard let items = obj["items"] as? [[String: Any]] else {
                        print("items is not much type")
                        throw error.badData
                    }
                    self.repository = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            // タスクを実行
            task?.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let detail = segue.destination as! SearchResultsViewController
            detail.repositorySearchViewController = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repository[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self) 
    }
    
}
