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
    
    var arrayOfLogangs = [Logangs]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let vlog1 = Logangs(imageURL: "http://i3.ytimg.com/vi/u67lapirxOc/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/u67lapirxOc\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "WENT TO HEAVEN!", viewsNumber: "3.942.783")
        let vlog2 = Logangs(imageURL: "http://i3.ytimg.com/vi/lkMw8qCCTZM/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/lkMw8qCCTZM\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "$100,000 VACATION!", viewsNumber: "5.312.003")
        let vlog3 = Logangs(imageURL: "http://i3.ytimg.com/vi/JeD3n4XaCl0/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/JeD3n4XaCl0\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "THE SECOND VERSE", viewsNumber: "2.337.653")
        let vlog4 = Logangs(imageURL: "http://i3.ytimg.com/vi/2TmCvvThx2w/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/2TmCvvThx2w\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "I sold my dog...", viewsNumber: "7.201.654")
        let vlog5 = Logangs(imageURL: "http://i3.ytimg.com/vi/WE6tOwSeiGY/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/WE6tOwSeiGY\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "THEY CAUGHT US...", viewsNumber: "10.202.358")
        let vlog6 = Logangs(imageURL: "http://i3.ytimg.com/vi/zLfn_n1Eqjw/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/zLfn_n1Eqjw\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "MY FIRST INTERNET DATE EVER!", viewsNumber: "6.286.986")
        let vlog7 = Logangs(imageURL: "http://i3.ytimg.com/vi/onm7U6lz0kA/maxresdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/onm7U6lz0kA\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "WE MADE ANOTHER SONG.", viewsNumber: "3.996.242")
        
        
        arrayOfLogangs.append(vlog1)
        arrayOfLogangs.append(vlog2)
        arrayOfLogangs.append(vlog3)
        arrayOfLogangs.append(vlog4)
        arrayOfLogangs.append(vlog5)
        arrayOfLogangs.append(vlog6)
        arrayOfLogangs.append(vlog7)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! LogangCell
        
        
        let currentCell = arrayOfLogangs[indexPath.row]
        
        cell.uptadeUI(logangs: currentCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfLogangs.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = arrayOfLogangs[indexPath.row]
        performSegue(withIdentifier: "VideoVC", sender: currentCell)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? VideoVC {
            if let logan = sender as? Logangs {
                destination.logangster = logan
                
            }
        }
        
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }
    
}

