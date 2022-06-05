//
//  SavedItemsTableViewController.swift
//  InColor
//
//  Created by Jacob Day on 4/16/22.
//
// Evan Japundza, evjapund - Eli Cohen, cohenelj - Jacob Day, day6 ---------- In Color ---------- 5/6/2022

import UIKit

class SavedItemsTableViewController: UITableViewController {
    var appDelegate: AppDelegate?
    var drawingData: DrawingDataModel?
    var arr: [Image] = []
    
    override func viewWillAppear(_ animated: Bool) {
        //gets all the saved images and puts them in this array
        arr = CoreDataHelper.shareInstance.fetchImage()
        
        if let lMyTableView = self.tableView {
            lMyTableView.reloadData()
        }
        self.tableView.rowHeight = 450
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.drawingData = self.appDelegate?.drawingData
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedItemCell", for: indexPath) as! SavedItemTableViewCell
                
        //check for items in the array
        if (indexPath.row > arr.count - 1) {
            return UITableViewCell()
        } else {
            //gets the number of the saved drawing based on the cell number
            let currentCell = arr[indexPath.row]
            
            //puts the saved drawing in the UIImageView
            cell.imageDisplay.image = UIImage(data: currentCell.img!, scale: 0.5)
            
            //tells what number drawing it is
            cell.drawingNumber.text = "Saved Drawing #\(indexPath.row)"
            
            // Hide share button on iPad due to conflicting constraints
            if (UIDevice.current.userInterfaceIdiom == .pad) {
                cell.shareButton.isHidden = true
            }
            
            // Pass shareImage event from cell to view controller
            cell.shareClosure = { [weak self] cell in
                // Create activity view controller for current cell image
                let activityController = UIActivityViewController(activityItems: [UIImage(data: currentCell.img!, scale: 1.0)!], applicationActivities: nil)
                
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    activityController.popoverPresentationController?.sourceView = self?.view
                    self?.present(activityController, animated: true, completion: nil)
                case .pad:
                    print("Sharing not supported.")
                default: break
                }
            }
            return cell
        }
    }
}
