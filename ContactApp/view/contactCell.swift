import UIKit
import Kingfisher

class NoteCell: UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var urlPhotoIV: UIImageView!
    
    
    func setDefault(){
        nameLabel.text = ""
        phoneNumberLabel.text = "No Phone numbers"
        urlPhotoIV.image = UIImage(named: "person.circle.fill")
    }
    func setContact(person:Person){
       setDefault()
        
        if let name = person.name, let surName = person.surName {
            nameLabel.text = "\(name) \(surName)"
        }
        
        if let photoUrl = person.photoURL{
            let url = URL(string: photoUrl)
            url?.isReachable(completion: { result in
                if result{
                    DispatchQueue.main.async {
                        self.urlPhotoIV.kf.setImage(with: url)
                    }
                }else{
                    let url = URL(string: DEFAULT_DATA.DEFAULT_IMAGE)
                    self.urlPhotoIV.kf.setImage(with: url)
                }
            })
            
        }
        
        if person.phoneNumber.count > 0 {
            phoneNumberLabel.text =  person.phoneNumber.count == 1 ? "\(person.phoneNumber.count) Phone Number" : "\(person.phoneNumber.count) Phone Numbers"
        }
        
        
    }
}
