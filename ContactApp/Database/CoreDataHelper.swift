//
//  coreDataHelper.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import CoreData
import UIKit

class CoreDataHelper:NSObject {
    
    static let shared = CoreDataHelper()
    
    var contactList:[Person] = [Person]()
  
    
    func storeData(){
        if let context = viewContext() {
            do {
                try context.save()
            }catch let err{
                print("Error while saving data in db \(err.localizedDescription)")
            }
        }
    }
    
    func setDefaultData(){
        fetchData()
        if (contactList.count == 0 ){
            if let viewContext = viewContext(){
                let entity = NSEntityDescription.entity(forEntityName: DB_TABLE.Person, in: viewContext)
                let newContact = Person(entity: entity!, insertInto: viewContext)
                
                newContact.id = NSNumber(value: 1)
                newContact.name = DEFAULT_DATA.MOCK_NAME1
                newContact.surName = DEFAULT_DATA.MOCK_SURNAME1
                newContact.photoURL = DEFAULT_DATA.MOCK_IMAGE1
                newContact.phoneNumber = DEFAULT_DATA.MOCK_PHONE1
                
                
                storeData()
                
                let newContact2 = Person(entity: entity!, insertInto: viewContext)
                
                newContact2.id = NSNumber(value: 2)
                newContact2.name = DEFAULT_DATA.MOCK_NAME2
                newContact2.surName = DEFAULT_DATA.MOCK_SURNAME2
                newContact2.photoURL = DEFAULT_DATA.MOCK_IMAGE2
                newContact2.phoneNumber = DEFAULT_DATA.MOCK_PHONE2

                
                storeData()
               
            }
           
          
            
        }
    }
    
    func fetchData(){
    contactList = [Person]()
        if let context = viewContext() {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: DB_TABLE.Person)
            do{
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let contact = result as! Person
                    contactList.append(contact)
                }
             }catch let error{
                print("Fetch Failed \(error.localizedDescription)")
            }
            
        }
    }
    
    func viewContext() -> NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return  appDelegate.persistentContainer.viewContext
        }
       return nil
    }
    
    func updateContact(contact:Person,phoneNumber:String){
        for result in contactList {
            if(result == contact){
                result.phoneNumber.append(phoneNumber)
                if let viewContext = viewContext(){
                    do{
                        try viewContext.save()
                    }catch let err{
                        print("error while updating")
                    }
                   
                }
             }
         }
    }

}
