//
//  AddContactViewModdel.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import Foundation
import UIKit
import CoreData


class AddContactViewModel:NSObject {
    weak var view:AddContactVC?
    
     init(view:AddContactVC){
         self.view = view
         super.init()
     }
    
    func setDefaultData(){
        view?.submitButton.isEnabled = false
        view?.nameError.isHidden = false
        view?.surNameError.isHidden = false
        
        view?.nameError.text = ""
        view?.surNameError.text = ""
        view?.urlError.text = ""
        
        view?.nameTF.text = ""
        view?.surNameTF.text = ""
        view?.urlPhotoTF.text = ""
        
        validateForm()
    }
    
    func validateForm(){
        guard let view = view else {return}
        if(view.nameError.isHidden && view.surNameError.isHidden){
            view.submitButton.isEnabled = true
            view.submitButton.backgroundColor = UIColor.systemBlue
        }else{
            view.submitButton.isEnabled = false
            view.submitButton.backgroundColor = UIColor.gray
        }
    }
    
    func handelTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)->Bool{
        guard let view = view else {return true}
        if (textField == view.nameTF){
            if let name = textField.text{
                let firstName:String = String(string.count > 0 ? "\(name)\(string)":name.dropLast())
               view.nameError.text = invalidName(firstName)
                view.nameError.isHidden = !(invalidName(firstName).count > 1)
            }
        }else if (textField == view.surNameTF){
            if let name = textField.text {
                let surName:String = String(string.count > 0 ? "\(name)\(string)":name.dropLast())
               view.surNameError.text = invalidSurName(surName)
                view.surNameError.isHidden = !(invalidSurName(surName).count > 1)
            }
        }
        validateForm()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let view = view else {return}
        if (textField == view.urlPhotoTF){
            if let urlStr = textField.text, let url = URL(string: urlStr){
                url.isReachable { result in
                    DispatchQueue.main.async {
                        view.urlError.text = self.invalidPhotoUrl(value: result)
                    }
                    
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let view = view else {return false}
        
        switch textField {
        case view.nameTF:
            view.surNameTF.becomeFirstResponder()
        case view.surNameTF:
            view.urlPhotoTF.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func invalidName(_ value: String) -> String
    {
        return value.count < 3 ? ERR_MESSAGE.NAME: ERR_MESSAGE.EMPTY
     }
    
    func invalidSurName(_ value: String) -> String{
        return value.count < 3 ? ERR_MESSAGE.SURNAME: ERR_MESSAGE.EMPTY
     }
    
    func invalidPhotoUrl(value:Bool) -> String{
        return !value ? ERR_MESSAGE.PHOTO: ERR_MESSAGE.EMPTY
     }
    
    func getContact()-> Person? {
        
        guard let viewContext = view?.viewContext() else {return nil}
        guard let view = view else {return nil}
        
        let entity = NSEntityDescription.entity(forEntityName: DB_TABLE.Person, in: viewContext)
        let newContact = Person(entity: entity!, insertInto: viewContext)
        newContact.id = NSNumber(value: Int32(truncating: CoreDataHelper.shared.contactList.count as NSNumber))
        newContact.name = view.nameTF.text
        newContact.surName = view.surNameTF.text
        if(view.urlPhotoTF.hasText){
            newContact.photoURL = view.urlPhotoTF.text
        }else{
            newContact.photoURL = view.defaultImage
        }
        
        return newContact
    }
    
    func submitBtnTapped(){
        if let newContact = getContact(){
            CoreDataHelper.shared.storeData()
            CoreDataHelper.shared.contactList.append(newContact)
        }
        view?.navigationController?.popViewController(animated: true)
        
        
    }
}
