//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by LuoLewis on 15/11/8.
//  Copyright © 2015年 LuoLewis. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    var meals=[Meal]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Load the sample data
        navigationItem.leftBarButtonItem=editButtonItem()
        
        
        if let loadMeal=loadMeals(){
            meals+=loadMeal
        }else{
        
        loadSampleMeals()
        }
        print(meals)
    }
    
    func loadSampleMeals(){
        let photo1=UIImage(named: "meal1")
        let meal1=Meal(name: "Caprese Salad", photo: photo1, rating: 4)!
        let photo2=UIImage(named: "meal2")
        
        let meal2=Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5)!
        
        let photo3=UIImage(named: "meal3")
        let meal3=Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3)!
        
        
        meals+=[meal1,meal2,meal3]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            //Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeal()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

        }else if editingStyle == .Insert{
            
        }
        
    }
    // Override to support conditional editing of the table view.
    override func tableView(tableVIew:UITableView,canEditRowAtIndexPath indexPath:NSIndexPath)->Bool{
        //Return false if you do not want the specified item to be editable
        return true
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier="MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTaleViewCell
        
        let meal=meals[indexPath.row]
       cell.nameLabel.text=meal.name1
        cell.mealPhoto.image=meal.photo1
        cell.mealRating.rating=meal.rating1

        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="showDetail"{
                    print("show detail")
            let mealDetailViewController=segue.destinationViewController as! MealViewController
            if let selectMealCell = sender as? MealTaleViewCell{
                let indexPath = tableView.indexPathForCell(selectMealCell)!
                let selectedMeal=meals[indexPath.row]
                mealDetailViewController.meal=selectedMeal
            }
        }else if segue.identifier=="AddItem"{
        
            print("add iten")
        }
    }
    @IBAction func unwindToMealList(sender:UIStoryboardSegue){
        
        if let sourViewController=sender.sourceViewController as? MealViewController,meal=sourViewController.meal{
            if let selectIndexPath=tableView.indexPathForSelectedRow{
                        meals[selectIndexPath.row]=meal
                tableView.reloadRowsAtIndexPaths([selectIndexPath], withRowAnimation: .None)
            }else {
            let newIndexPath=NSIndexPath(forRow: meals.count, inSection: 0)
            meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)}
            
            saveMeal()
        }
    }
    //MARK: NSCoding
    
    func saveMeal(){
        let isSuccessfulSave=NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        
        if !isSuccessfulSave{
            print("save meal is failed")
        }
    }
    
    func loadMeals()->[Meal]?{
            return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
    
}
