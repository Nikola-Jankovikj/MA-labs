//
//  FoodViewController.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 3.5.24.
//

import UIKit

class FoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var foods: [Consumable] =
    [
        Consumable(name: "Hamburger", type: "Meat", image: UIImage(systemName: "square.fill")!, description: "High protein, high calories, not healthy"),
        Consumable(name: "Pizza", type: "Meat", image: UIImage(systemName: "triangle.fill")!, description: "High protein, high calories, not healthy"),
        Consumable(name: "Salad", type: "Vegan", image: UIImage(systemName: "circle.fill")!, description: "Healtyh low calorie")
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

extension FoodViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "foodDetailsViewController") as! FoodDetailsViewController
        
        vc.navigationItem.title = foods[indexPath.row].name
        
        vc.selectedFood = foods[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsumableTableViewCell.identifier, for: indexPath) as! ConsumableTableViewCell
        
        cell.foodImageView.image = foods[indexPath.row].image
        cell.foodTitleLabel.text = foods[indexPath.row].name
        cell.foodTypeLabel.text = foods[indexPath.row].type
        
        return cell
    }
    
    
}
