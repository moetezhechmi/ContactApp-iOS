




//
//  AddPhoneViewController.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 20/7/2022.
//

import UIKit
import CoreData



class AddPhoneViewController: UIViewController {

    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addPhoneButton: UIButton!
    @IBOutlet weak var phoneError: UILabel!
  
    var selectedContact:Person?
    
    var viewModel:AddPhoneViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AddPhoneViewModel(view: self)
        viewModel?.setDefaultCountryCode()
    }

    @IBAction func saveNumber(_ sender: Any)
    {
        viewModel?.updateNumber()
    }
    
}

extension AddPhoneViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModel?.handelTextField(textField, shouldChangeCharactersIn: range, replacementString: string) ?? false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel?.handelTextFieldDidEndEditing(textField)
    }
}
