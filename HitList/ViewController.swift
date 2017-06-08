//
//  ViewController.swift
//  HitList
//
//  Created by Seunghun Lee on 2017-06-08.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    // MARK: Properties

    @IBOutlet weak var tableView: UITableView!

    var names = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let name = names[indexPath.row]

        if let label = cell.textLabel {
            label.text = name
        }

        return cell
    }

    // MARK: Actions
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction) in
            let textField = alert.textFields!.first
            self.names.append(textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addTextField(configurationHandler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

}

