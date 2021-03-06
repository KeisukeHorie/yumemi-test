//
//  GetImageFile.swift
//  iOSEngineerCodeCheck
//
//  Created by 堀江勁丞 on 2022/02/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension RepositorySearchViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchWord = searchBar.text!
        
        if searchWord.count != 0 {
            let url = "https://api.github.com/search/repositories?q=\(searchWord)"
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
}

extension SearchResultsViewController {
    func getImage() {
        
        let repository = searchViewController.repository[searchViewController.index]
        
        titleLabel.text = repository["full_name"] as? String
        
        if let owner = repository["owner"] as? [String: Any] {
            guard let imageURL = owner["avatar_url"] as? String else {
                print("bad URL string")
                return
            }
            URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, res, err) in
                do{
                    if let error = err {
                        throw error
                    }
                    guard let imageData = data else {
                        print("bad data")
                        throw error.badData
                    }
                    guard let avatarImage = UIImage(data: imageData) else {
                        print("bad data")
                        throw error.badData
                    }
                    DispatchQueue.main.async {
                        self.avatarImageView.image = avatarImage
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
}




