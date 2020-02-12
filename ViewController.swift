//
//  ViewController.swift
//  TableViewExampe
//
//  Created by Matěj Žemlička on 28/01/2020.
//  Copyright © 2020 Matěj Žemlička. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvNews: UITableView!
    
    private var news: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvNews.delegate = self
        tvNews.dataSource = self
        
    Alamofire.request("https://newsapi.org/v2/everything?q=apple&from=2020-01-27&to=2020-01-27&sortBy=popularity&apiKey=1f822e3a8be14d43a008bcb21d7d00c5").responseJSON {
            (response) in let json = try! JSON(data: response.data!)
            
        print(json)
        
            let arr = json["articles"].arrayValue
            
            for article in arr {
                let a = Article(title: article["title"].stringValue, description: article["description"].stringValue, link: article["url"].stringValue)
                self.news.append(a)
                
            }
            self.tvNews.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom-cell") as! CustomCell
        let indexCell = indexPath.item
        
        
        let title = news[indexCell].title
        let description = news[indexCell].description
        let link = news [indexCell].link
        
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        cell.link.text = link

        return cell;
    }
    

}


