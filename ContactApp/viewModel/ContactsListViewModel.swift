//
//  ContactsListViewModel.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import Foundation
import UIKit
import CoreData

class ContactsListViewModel:NSObject {
    weak var view:ContactsListViewController?
    
     init(view:ContactsListViewController){
         self.view = view
         
         super.init()
     }
    
    func reloadData(){
        view?.contactListTableView?.reloadData()
    }
    
    func fetchContactList(){
        CoreDataHelper.shared.fetchData()
    }
    
    func numberOfRowsInSection()->Int{
        return CoreDataHelper.shared.contactList.count
    }
    
    func cellForRowAt(indexPath:IndexPath)->UITableViewCell{
        guard let tblView = view?.contactListTableView else {return UITableViewCell()}
        
        if let cell = tblView.dequeueReusableCell(withIdentifier: TABLE_IDENTIFIER.NoteCellID, for: indexPath) as? NoteCell{
            cell.setContact(person: CoreDataHelper.shared.contactList[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
                if(segue.identifier == SEGUE.CONTACT_DETAIL)
                {
                    guard let view = view else {return}
                     if let indexPath = view.contactListTableView?.indexPathForSelectedRow {
                        if let noteDetail = segue.destination as? ContactDetailsViewController {
                            noteDetail.selectedContact = CoreDataHelper.shared.contactList[indexPath.row]
                        }
                        view.contactListTableView?.deselectRow(at: indexPath, animated: true)
                    }
                }
    }
    
    
}
