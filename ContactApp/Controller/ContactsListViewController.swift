//
//  ContactsListViewController.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import UIKit

class ContactsListViewController:UIViewController {
    
    @IBOutlet weak var contactListTableView:UITableView?
    var viewModel:ContactsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContactsListViewModel(view: self)
        viewModel?.fetchContactList()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.reloadData()
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        viewModel?.prepare(for: segue, sender: sender)
    }
    
}


extension ContactsListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.cellForRowAt(indexPath: indexPath) ?? UITableViewCell()
    }
}



