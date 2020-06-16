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
    @IBOutlet weak var articleText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = article.title
        articleText.text = article.fullText
    }
    



}
