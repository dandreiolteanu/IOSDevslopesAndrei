//
//  MainVC.swift
//  iWantThat
//
//  Created by Mac on 17/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var shopPicker: UIPickerView!
    @IBOutlet weak var shopPickerBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    var inSearchMode = false
    
    var stores = [Store]()
    var filteredItemsByStore = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        shopPicker.delegate = self
        shopPicker.dataSource = self
        
        searchBar.delegate = self
        
        
//        generateTestData()
        
        
        getStores()
        attemptFetch()
    }
    
    
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.shopPicker.reloadAllComponents()
            
        } catch {
            
            // handle the error
        }
    }

    
//    SearchBar functions 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            do {
                controller.fetchRequest.predicate = nil
                try controller.performFetch()
                self.tableView.reloadData()
                searchBar.resignFirstResponder()
            } catch {
                
                print("fetch task failed", error)
            }
            
        } else {
            do {
                
                var predicate:NSPredicate? = nil
                predicate = NSPredicate(format: "(title contains [cd] %@) || (title contains[cd] %@)", searchBar.text!, searchBar.text!)
                controller.fetchRequest.predicate = predicate
                try controller.performFetch()
                self.tableView.reloadData()
            } catch {
                
            print ("fetch task failed", error)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.view.endEditing(true)
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        
//        searchBar.resignFirstResponder()
//        searchBar.text = ""
//        controller.fetchRequest.predicate = nil
//    }
    
    
//    PickerView functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        shopPickerBtn.setTitle(stores[row].name, for: UIControlState())
        shopPicker.isHidden = true
        tableView.isHidden = false
        print("before fetching")
        
        //let context1 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            var predicate:NSPredicate? = nil
            predicate = NSPredicate(format: "toStore.name =%@", (shopPickerBtn.titleLabel?.text)!)
            controller.fetchRequest.predicate = predicate
            try controller.performFetch()
            tableView.reloadData()
        }
        catch {
            print ("fetch task failed", error)
        }

        print("after fetching")
        tableView.reloadData()
    }
    
    @IBAction func shopPickerBtnPressed(_ sender: Any) {
        
        shopPicker.isHidden = false
        tableView.isHidden = true
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        
        //Update cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects, objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ItemDetailsVC" {
            
            if let destination = segue.destination as? ItemDetailsVC {
                
                if let item = sender as? Item {
                    
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        if segment.selectedSegmentIndex == 0 {
            
            fetchRequest.sortDescriptors = [dateSort]
            
        } else if  segment.selectedSegmentIndex == 1 {
            
            fetchRequest.sortDescriptors = [priceSort]
            
        } else if segment.selectedSegmentIndex == 2 {
            
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            
            try controller.performFetch()
        } catch {
            
            let error = error as NSError
            print("\(error)")
        }
    }
    
//    Segment changed 
    @IBAction func segmentChange(_ sender: Any) {
        
        attemptFetch()
        tableView.reloadData()
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                // update the cell data
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }
    
    
    func generateTestData() {
        
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "Looking forward to buying a new one.Hope they'll make a good job with this one."
        
        let item1 = Item(context: context)
        item1.title = "iPhone 8"
        item1.price = 1000
        item1.details = "September here I come.Can't wait for you to show off."
        
        let item2 = Item(context: context)
        item2.title = "Filling Pieces Shoes"
        item2.price = 240
        item2.details = "I'll look sharp with this one on my feet.Black on black hell yeah."
        
        ad.saveContext()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
