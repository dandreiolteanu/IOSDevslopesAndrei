//
//  ViewController.swift
//  LogangVlogs
//
//  Created by Mac on 06/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var logangCells = [Logangs]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let vlog1 = Logangs(imageURL: "http://i3.ytimg.com/vi/u67lapirxOc/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/u67lapirxOc\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "I DIED AND WENT TO HEAVEN!")
        let vlog2 = Logangs(imageURL: "http://i3.ytimg.com/vi/lkMw8qCCTZM/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/lkMw8qCCTZM\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "$100,000 DREAM VACATION!")


        logangCells.append(vlog1)
        logangCells.append(vlog2)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LogangCell", for: indexPath) as? LogangCell {
            
            let logangCell = logangCells[indexPath.row]
            
            cell.uptadeUI(logangs: logangCell)
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logangCells.count
    }


}

