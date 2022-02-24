//
//  SearchResultsViewContoroller.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLable: UILabel!
    @IBOutlet weak var isuuesLabel: UILabel!
    
    var searchViewController: RepositorySearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = searchViewController.repository[searchViewController.index]
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLable.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        isuuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        
        getImage()
    }
    
    
//    func getImage(){
//        
//        let repository = searchViewController.repository[searchViewController.index]
//        
//        titleLabel.text = repository["full_name"] as? String
//        
//        if let owner = repository["owner"] as? [String: Any] {
//            guard let imgURL = owner["avatar_url"] as? String else {
//                print("bad URL string")
//                return
//            }
//            URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
//                do{
//                    if let error = err {
//                        throw error
//                    }
//                    guard let imgData = data else {
//                        print("bad data")
//                        throw error.badData
//                    }
//                    guard let avatarImg = UIImage(data: imgData) else {
//                        print("bad data")
//                        throw error.badData
//                    }
//                    DispatchQueue.main.async {
//                        self.avatarImageView.image = avatarImg
//                    }
//                } catch {
//                    print(error)
//                }
//            }.resume()
//        }
//    }
//    
}


    
