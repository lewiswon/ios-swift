//
//  MealViewController.swift
//  FoodTracker
//
//  Created by LuoLewis on 15/11/3.
//  Copyright © 2015年 LuoLewis. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//MARK: IBOutlet
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControll: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal:Meal?
    
    override func viewDidLoad() {
               super.viewDidLoad()
        nameTextField.delegate=self
        
        if let meal = meal{
            navigationItem.title=meal.name1
            nameTextField.text=meal.name1
            photoImageView.image=meal.photo1
            ratingControll.rating=meal.rating1
        }
        checkValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton{
            let name=nameTextField.text ?? ""
            let photo=photoImageView.image
            let rating=ratingControll.rating
            meal=Meal(name: name, photo: photo, rating: rating)
            
            
        }
    }
// MARK: IBAction

    @IBAction func cancle(sender: UIBarButtonItem) {
        
        let isPresentingInAddMealMode=presentationController is UINavigationController
        
        if isPresentingInAddMealMode{
            dismissViewControllerAnimated(true, completion: nil)
        }else {
        
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    @IBAction func pickFoodImage(sender: UITapGestureRecognizer) {
        
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .PhotoLibrary
        
//        let alertController=UIAlertController()
//        alertController.title="Hello World"
//        alertController.showViewController(self, sender: sender)
//        let actionSheet=UIActionSheet()
//        actionSheet.title="Hello"
//        actionSheet.delegate=nil
        
//        actionSheet.showInView(self.view)
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title=textField.text
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled=false
    }
    func checkValidMealName(){
        let text=nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectImage=info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image=selectImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

