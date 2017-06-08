//
//  ViewController.swift
//  HitList
//
//  Created by Seunghun Lee on 2017-06-08.
//  Copyright © 2017 Seunghun Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    // MARK: Properties

    @IBOutlet weak var tableView: UITableView!

    var people = [NSManagedObject]()


    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")

        do {
            let result = try managedContext.fetch(fetchRequest)
            people = result
        } catch let error as NSError {
            fatalError("Could not fetch \(error), \(error.userInfo)")
        }
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let person = people[indexPath.row]

        if let label = cell.textLabel {
            label.text = person.value(forKey: "name") as? String
        }

        return cell
    }

    // MARK: Actions
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction) in
            let textField = alert.textFields!.first
            self.saveName(name: textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addTextField(configurationHandler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    // MARK: Private Methods

    private func saveName(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(name, forKey: "name")

        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            fatalError("Could not save \(error), \(error.userInfo)")
        }

    }

}

