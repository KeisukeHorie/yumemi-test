//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLable: UILabel!
    @IBOutlet weak var isuuesLabel: UILabel!
    
    var vc1: RepositorySearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = vc1.repository[vc1.index]
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLable.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        isuuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        
        getImage()
        
    }
    
    func getImage(){
        
        let repository = vc1.repository[vc1.index]
        
        titleLabel.text = repository["full_name"] as? String
        
        if let owner = repository["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
}
