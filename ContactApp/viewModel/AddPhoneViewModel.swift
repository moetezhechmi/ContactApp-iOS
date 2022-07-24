//
//  AddPhoneViewModel.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import UIKit


class AddPhoneViewModel:NSObject {
    var view:AddPhoneViewController?
    var filledPrefix = "+421"
    let prefixs: [String] = ["+420","+421","+44","+49"]

    
    init(view:AddPhoneViewController){
        self.view = view
        super.init()
    }
    
    func setDefaultCountryCode(){
        view?.phoneTF.text = filledPrefix
        
    }
    
    func handelTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = view?.phoneTF.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        view?.phoneTF.text = formatter(mask: "+XXX XXXX XXX XXX", phoneNumber: newString)
        
        checkValidForm()
        return false
    }
    
    func handelTextFieldDidEndEditing(_ textField: UITextField){
        checkValidForm()
    }
    
    func formatter(mask: String, phoneNumber: String) -> String{
    
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        for character in mask where index < number.endIndex {
            if character == "X"{
                result.append(number[index])
                index = number.index(after: index)
                
            }else{
                result.append(character)
            }
        }
        return result
    }
    
    func resetForm(){
        guard let view = view else {return }
        view.addPhoneButton.isEnabled = false
        view.phoneError.isHidden = false
        view.phoneError.text = ""
        view.phoneTF.text = filledPrefix
        
    }
    

    
    func checkValidForm(){
        guard let view = view else {return }
        guard let number = view.phoneTF.text else {return }
       view.phoneError.text = validPhoneNumber(number)
            view.addPhoneButton.isEnabled = !(validPhoneNumber(number).count > 0)
            view.addPhoneButton.backgroundColor = validPhoneNumber(number).count > 0 ? UIColor.gray : UIColor.systemBlue
        
    }
    
    func validPhoneNumber(_ number:String)->String{
        var validPrefix = false
        for mockPrefix in prefixs{
            if number.contains(mockPrefix){
                validPrefix = true
                break
            }
        }
        
        return validPrefix && number.count > 12 ? ERR_MESSAGE.EMPTY : ERR_MESSAGE.PHONE_NUMBER
        
    }
    
    func updateNumber(){
        if let phoneNumber = view?.phoneTF.text, let contact = view?.selectedContact {
            CoreDataHelper.shared.updateContact(contact: contact, phoneNumber: phoneNumber)
        }
        view?.navigationController?.popViewController(animated: true)
    }
}
