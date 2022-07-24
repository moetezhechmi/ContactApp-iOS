import UIKit
import CoreData

class AddContactVC: UIViewController
{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surNameTF: UITextField!
    @IBOutlet weak var urlPhotoTF: UITextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var surNameError: UILabel!
    @IBOutlet weak var urlError: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var defaultImage = IMAGE.DEFAULT_IMAGE
    var selectedContact:Person?
    
    var viewModel:AddContactViewModel?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewModel = AddContactViewModel(view: self)
        viewModel?.setDefaultData()
   }
   
    @IBAction func submitAction(_ sender: Any) {
         viewModel?.submitBtnTapped()
    }
   
}


extension AddContactVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return viewModel?.handelTextField(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel?.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return viewModel?.textFieldShouldReturn(textField) ?? false
    }
}



