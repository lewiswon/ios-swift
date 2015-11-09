//
//  Meal.swift
//  FoodTracker
//
//  Created by LuoLewis on 15/11/5.
//  Copyright © 2015年 LuoLewis. All rights reserved.
//

import UIKit
class Meal:NSObject,NSCoding{
//MARK: Properties
//    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let DocumentDictionary = NSFileManager().URLsForDirectory(.DocumentDirectory,inDomains:.UserDomainMask).first!
    static let ArchiveURL = DocumentDictionary.URLByAppendingPathComponent("meals")
    
    struct ProperKey {
        static let nameKey="name"
        static let photoKey="photo"
        static let ratingKey="rating"
    }
  
    
    var name1:String
    var photo1:UIImage?
    var rating1:Int
    
//MARK: Initialization
  
    init?(name:String,photo:UIImage?,rating:Int){
        
        self.name1=name
        
        self.photo1=photo
        
        self.rating1=rating
        
        super.init()
        print("\(name.isEmpty)\((rating<0))")
        
        //Initialization should fail if there is no name or if the rating is negative
        if name.isEmpty || rating < 0 {
            
            return nil
        
        }
    }
   
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name1,forKey: ProperKey.nameKey)
        aCoder.encodeObject(photo1,forKey: ProperKey.photoKey)
//        aCoder.encodeObject(rating1,forKey: ProperKey.ratingKey)
        aCoder.encodeInteger(rating1, forKey: ProperKey.ratingKey)
    }
  
    required convenience init?(coder aDecoder: NSCoder) {
            let name1=aDecoder.decodeObjectForKey(ProperKey.nameKey) as! String
            let photot1=aDecoder.decodeObjectForKey(ProperKey.photoKey) as? UIImage
            let rating1=aDecoder.decodeIntegerForKey(ProperKey.ratingKey)
            self.init(name:name1,photo:photot1,rating:rating1)
    }
}
