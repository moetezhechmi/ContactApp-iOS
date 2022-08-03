//
//  ContactDetailsViewModel.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import Foundation
import UIKit

class ContactDetailsViewModel :NSObject {
    weak var view:ContactDetailsViewController?
    
    init(view:ContactDetailsViewController){
        self.view = view
        super.init()
    }
    
    var navBarTitle:String {
        if let name = view?.selectedContact?.name,
           let surName = view?.selectedContact?.surName {
            return "\(name) \(surName)"
        }else  if let name = view?.selectedContact?.name {
            return "\(name)"
        }
        
        return ""
    }
    

    
    func numberOfSections()->Int{
        if let _ = view?.selectedContact?.phoneNumber {
            return 1
        }
        return 0
    }
    func didSelectRowAt(indexPath:IndexPath){
        if let phoneNumbers = view?.selectedContact?.phoneNumber{
            let phoneNumer = phoneNumbers[indexPath.row]
            let trimmed = phoneNumer.replacingOccurrences(of: " ", with: "")

            if let phoneCallURL = URL(string: "tel://\(trimmed)") {

               let application:UIApplication = UIApplication.shared
               if (application.canOpenURL(phoneCallURL)) {
                   application.open(phoneCallURL, options: [:], completionHandler: nil)
               }
             }
        }
    }
    
    func setUpTableView(){
        guard let view = view else {return}
        
        view.tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: TABLE_IDENTIFIER.PhoneCellID)
        view.tableView.dataSource = view
        view.tableView.delegate = view
        view.tableView.tableHeaderView = viewForHeaderInSection()
    }
    
    
    func heightForHeader()->CGFloat{
        if let _ = view?.selectedContact?.phoneNumber {
            return CGFloat(40.0)
        }
        
        return CGFloat(0.0)
    }
    
    func viewForHeaderInSection()->UIView?{
        
        if let _ = view?.selectedContact?.phoneNumber {
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
            let headerView = UIView(frame: frame)
            let imageFrame = CGRect(x: (UIScreen.main.bounds.size.width - 134)/2, y: 33, width: 134, height: 134)
            let imageView = UIImageView(frame: imageFrame)
            imageView.layer.cornerRadius = 67
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            
            if let photoUrl = view?.selectedContact?.photoURL{
                let url = URL(string: photoUrl)
                url?.isReachable(completion: { result in
                    if result{
                        imageView.kf.setImage(with: url)
                    }else{
                        let url1 = URL(string: DEFAULT_DATA.DEFAULT_IMAGE)
                        imageView.kf.setImage(with: url1)
                    }

                })
                
            }
            
            
        
            
            headerView.addSubview(imageView)
            
            return headerView
            
        }
        
        return nil
    }
    
    func headerInSection()->UIView?{
        
        if let _ = view?.selectedContact?.phoneNumber {
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40)
            let headerView = UIView(frame: frame)
            headerView.backgroundColor = UIColor.darkGray
            
            let label = UILabel(frame: CGRect(x: 10, y: 8, width: 200, height: 20))
            label.textColor = UIColor.white
            label.text = "Phone Number"
            label.font = UIFont.systemFont(ofSize: 18)
            headerView.addSubview(label)
            
            return headerView
            
        }
        
        return nil
    }
    
    
    func numberOfRowsInSection()->Int{
        return view?.selectedContact?.phoneNumber.count ?? 0
    }
    
    func cellForRow(indexPath:IndexPath)->UITableViewCell {
        guard let tableView = view?.tableView else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_IDENTIFIER.PhoneCellID,for: indexPath)
        if let phoneNumbers = view?.selectedContact?.phoneNumber{
            cell.textLabel?.text = phoneNumbers[indexPath.row]
            cell.selectionStyle = .none
        }
        return cell
    }
    
     func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == SEGUE.ADD_PHONE)
        {
            let destinationVC = segue.destination as? AddPhoneViewController
            destinationVC?.selectedContact = view?.selectedContact
            
            let backItem = UIBarButtonItem()
               backItem.title = ""
            view?.navigationItem.backBarButtonItem = backItem
            
        }
    }
   
}
