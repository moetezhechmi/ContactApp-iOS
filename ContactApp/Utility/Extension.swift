//
//  Extension.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import UIKit
import CoreData

extension URL {
    func isReachable(completion: @escaping (Bool) -> ()) {
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"
        URLSession.shared.dataTask(with: request) { _, response, _ in
            completion((response as? HTTPURLResponse)?.statusCode == 200)
        }.resume()
    }
}

extension UIViewController {
    func viewContext()->NSManagedObjectContext?{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.persistentContainer.viewContext
    }
}
