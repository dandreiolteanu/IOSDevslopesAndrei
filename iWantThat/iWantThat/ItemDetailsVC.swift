//
//  ItemDetailsVCViewController.swift
//  iWantThat
//
//  Created by Mac on 17/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
//        let store = Store(context: context)
//        store.name = "Altex"
//        let store1 = Store(context: context)
//        store1.name = "iStyle"
//        let store2 = Store(context: context)
//        store2.name = "Autoworld"
//        let store3 = Store(context: context)
//        store3.name = "Emag"
//        let store4 = Store(context: context)
//        store4.name = "Olx"
//        let store5 = Store(context: context)
//        store5.name = "Filling Pieces"
//        let store6 = Store(context: context)
//        store6.name = "Gucci"
//        let store7 = Store(context: context)
//        store7.name = "Adidas"
//        let store8 = Store(context: context)
//        store8.name = "Nike"
//        let store9 = Store(context: context)
//        store9.name = "Domo"
//        let store10 = Store(context: context)
//        store10.name = "Amazon"
//
//        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            
            loadItemData()
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // update when selected
    }

    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        } catch {
            
            // handle the error
        }
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        var item: Item!
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
        }
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    } else {
                        
                        index = index + 1
                    }
                    
                } while (index < stores.count)
            }
        }
    }
    
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
   
}
