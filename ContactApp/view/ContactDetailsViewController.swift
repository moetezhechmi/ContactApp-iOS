//
//  ContactDetailsViewController.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 20/7/2022.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    var viewModel:ContactDetailsViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedContact: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContactDetailsViewModel(view: self)
        viewModel?.setUpTableView()
        self.navigationItem.title = viewModel?.navBarTitle
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        viewModel?.prepare(for: segue, sender: sender)
    }

}

extension ContactDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel?.cellForRow(indexPath: indexPath) ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 0
    }
}

extension ContactDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel?.headerInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel?.heightForHeader() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(indexPath: indexPath)
    }
}
