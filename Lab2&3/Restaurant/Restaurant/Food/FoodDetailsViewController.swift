//
//  FoodDetailsViewController.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 3.5.24.
//

import UIKit

class FoodDetailsViewController: UIViewController {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionText: UITextView!
    @IBOutlet weak var commentTableView: UITableView!
    
    var selectedFood: Consumable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        commentTableView.rowHeight = UITableView.automaticDimension
        
        foodImage.image = selectedFood?.image
        foodNameLabel.text = selectedFood?.name
        foodDescriptionText.text = selectedFood?.description
        
        commentTableView.register(CommentTableViewCell.nib(), forCellReuseIdentifier: CommentTableViewCell.identifier)
        
    }
    

    @IBAction func makeHttpReqPressed(_ sender: Any) {
        
        guard let url = URL(string: "https://dummyjson.com/products/1") else {
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }

                    guard let data = data else {
                        print("Data is nil")
                        return
                    }

                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = json as? [String: Any],
                           let title = dict["title"] as? String {
                            DispatchQueue.main.async {
                                self.showAlert(title: title)
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }.resume()
        
    }
    
    func showAlert(title: String) {
           let alertController = UIAlertController(title: "Product Title", message: title, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
       }
    
    @IBAction func addCommentPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Enter Text", message: nil, preferredStyle: .alert)

                // Add a text field to the alert controller
                alertController.addTextField { (textField) in
                    textField.placeholder = "Enter text here"
                }

                // Create action
                let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    // When OK button tapped, get the text entered
                    if let text = alertController.textFields?[0].text {
                        print("Text entered: \(text)")
                        // Do something with the entered text
                        
                        guard let name = self.selectedFood?.name,
                           var savedArray = UserDefaults.standard.object(forKey: name) as? Array<String>
                        else {
                            UserDefaults.standard.setValue([text], forKey: self.selectedFood?.name ?? "")
                            self.commentTableView.reloadData()
                            return
                        }
                            
                        savedArray.append(text)
                        UserDefaults.standard.setValue(savedArray, forKey: name)
                            
                        
                        self.commentTableView.reloadData()
                    }
                }

                // Add action to alert controller
                alertController.addAction(confirmAction)

                // Present the alert controller
                present(alertController, animated: true, completion: nil)
    }
    
}

extension FoodDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var savedArray = UserDefaults.standard.object(forKey: selectedFood?.name ?? "") as? Array<String>
        return savedArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        
        var savedArray = UserDefaults.standard.object(forKey: selectedFood?.name ?? "") as? Array<String>
        
        cell.comment.text = savedArray?[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    
}
