//
//  FavoriteStateViewController.swift
//  COVID in the US
//
//  Created by Erik Villavera on 1/26/21.
//

import UIKit

class FavoriteStateViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    static var index: [Int] = []
    static var stateNames: [String] = []
    static var todayCases: [Int] = []
    static var todayDeaths: [Int] = []
    static var allTimeCases: [Int] = []
    static var allTimeDeaths: [Int] = []

    @IBOutlet weak var statesTableView: UITableView!
    @objc func reloadTableview() {
//        print("Reloading data")
        self.statesTableView.reloadData()
//        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statesTableView.dataSource = self
        statesTableView.delegate = self

//        print(FavoriteStateViewController.stateNames)
//        print(FavoriteStateViewController.todayCases)
//        print(FavoriteStateViewController.todayDeaths)
//        print(FavoriteStateViewController.index)
        // Do any additional setup after loading the view.
        
        let notificationNme = NSNotification.Name("NotificationIdf")
        NotificationCenter.default.addObserver(self, selector: #selector(FavoriteStateViewController.reloadTableview), name: notificationNme, object: nil)
        
        self.statesTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 55
        return FavoriteStateViewController.index.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavStateCell") as! StateCell
//        print("Inside cell making process")
//        print(stateNames)
        if (FavoriteStateViewController.stateNames.count == 0 || FavoriteStateViewController.todayCases.count == 0 || FavoriteStateViewController.todayDeaths.count == 0){
            print(FavoriteStateViewController.stateNames.count)
            print(FavoriteStateViewController.todayCases.count)
            print(FavoriteStateViewController.todayDeaths.count)
            return cell
        }else{
            let state = FavoriteStateViewController.stateNames[FavoriteStateViewController.index[indexPath.row]]
            let caseNum = FavoriteStateViewController.todayCases[FavoriteStateViewController.index[indexPath.row] + 55] - FavoriteStateViewController.todayCases[FavoriteStateViewController.index[indexPath.row]]
            let deathNum = FavoriteStateViewController.todayDeaths[FavoriteStateViewController.index[indexPath.row] + 55] - FavoriteStateViewController.todayDeaths[FavoriteStateViewController.index[indexPath.row]]
            var status: String
            if caseNum > 0 {
                status = "Increasing"
            }else if caseNum < 0  {
                status = "Decreasing"
            }else{
                status = "Need More Information"
            }
            
            cell.stateName.text = state
            cell.diffCases.text = "Cases: \(String(caseNum))"
            cell.diffDeaths.text = "Deaths: \(String(deathNum))"
            cell.status.text = "Status: \(status)"
            
            return cell
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        print("Loading up Details Screen")
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = statesTableView.indexPath(for: cell)!
        let stateName = FavoriteStateViewController.stateNames[FavoriteStateViewController.index[indexPath.row]]
//        let caseNum = todayCases[indexPath.row]
        //Pass the selected movie to the Details VC
        
        let stateDetailViewController = segue.destination as! StateDetailViewController
        
        stateDetailViewController.index = FavoriteStateViewController.index[indexPath.row]
        stateDetailViewController.stateName = stateName
        stateDetailViewController.todayCases = FavoriteStateViewController.todayCases
        stateDetailViewController.todayDeaths = FavoriteStateViewController.todayDeaths
        
        statesTableView.deselectRow(at: indexPath, animated: true)
    }

}
