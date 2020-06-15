//
//  ArticleViewController.swift
//  VestiRu
//
//  Created by Marina Svistkova on 10.06.2020.
//  Copyright © 2020 Marina Svistkova. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: RSSItem!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        articleLabel.lineBreakMode = .byWordWrapping
        titleLabel.text = article.title
        articleLabel.text = article.fullText
    }
    



}
