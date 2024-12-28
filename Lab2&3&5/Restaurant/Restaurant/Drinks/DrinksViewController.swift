//
//  DrinksViewController.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 3.5.24.
//

import UIKit

class DrinksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var drinks: [Consumable] =
    [
        Consumable(name: "Coca-Cola", type: "Fizzy", image: UIImage(systemName: "square.fill")!, description: "Coca-Cola is a company built a long time ago that makes fizzy drinks"),
        Consumable(name: "Orange Juice", type: "Soft", image: UIImage(systemName: "triangle.fill")!, description: "A lot of sugar dont be fooled it is not healthy.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ConsumableTableViewCell.nib(), forCellReuseIdentifier: ConsumableTableViewCell.identifier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DrinksViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "foodDetailsViewController") as! FoodDetailsViewController
        
        vc.navigationItem.title = drinks[indexPath.row].name
        
        vc.selectedFood = drinks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsumableTableViewCell.identifier, for: indexPath) as! ConsumableTableViewCell
        
        cell.foodImageView.image = drinks[indexPath.row].image
        cell.foodTitleLabel.text = drinks[indexPath.row].name
        cell.foodTypeLabel.text = drinks[indexPath.row].type
        
        return cell
        
    }
    
    
}
