//
//  XLMParcer.swift
//  VestiRu
//
//  Created by Marina Svistkova on 10.06.2020.
//  Copyright © 2020 Marina Svistkova. All rights reserved.
//

import Foundation

import Foundation

struct RSSItem {
    var title: String
    var fullText: String
    var pubDate: String
    var img: String

}

class FeedParser: NSObject, XMLParserDelegate {
    private var rssItems : [RSSItem] = []
    private var currentElement = ""
    private var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentImg = ""
    private var currentFullText = ""
    private var currentPubDate = "" {
        didSet{
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.newlines)
        }
    }
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed (url: String, completionHandler: (([RSSItem]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            // parse our xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }
        task.resume()
    }
    
    //MARK: - XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item"{
            currentTitle = ""
            currentFullText = ""
            currentPubDate = ""
        } else if currentElement == "enclosure" {
            if let urlString = attributeDict["url"] {
                currentImg = urlString
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title": currentTitle += string
        case "yandex:full-text": currentFullText += string
        case "pubDate": currentPubDate += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, fullText: currentFullText, pubDate: currentPubDate, img: currentImg)
            self.rssItems.append(rssItem)
        }
    }
    
    //когда все статьи подгрузятся
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    // if error occured
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

