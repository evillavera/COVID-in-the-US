//
//  StateDetailViewController.swift
//  COVID in the US
//
//  Created by Erik Villavera on 1/25/21.
//

import UIKit

class StateDetailViewController: UIViewController {
    
    var index = 0;
    var stateNames: [String] = []
    var todayCases: [Int] = []
    var todayDeaths: [Int] = []
    var stateName = "Hello"
    
    var inputCases: [Int] = []
    var inputDeaths: [Int] = []
    
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var allTimeCasesLabel: UILabel!
    @IBOutlet weak var allTimeDeathsLabel: UILabel!
    @IBOutlet weak var todayCasesLabel: UILabel!
    @IBOutlet weak var todayDeathsLabel: UILabel!
    @IBOutlet weak var dayInput: UITextField!
    
    @IBOutlet weak var resultCasesLabel: UILabel!
    @IBOutlet weak var resultDeathsLabel: UILabel!
    @IBOutlet weak var resultErrorMessage: UILabel!
    
    @IBAction func calculateData(_ sender: Any) {
        
        //let state = "new%20york"
        //let days = "2"
//        let inputResult = Int(dayInput.text!)
//        if inputResult! < 15 && inputResult! > 0{
//            let days = dayInput.text
//        }else{
//            dayInput.placeholder = "Invalid Input"
//            return
//        }
        
//        let days = dayInput.text
        
        guard let days = Int(dayInput.text!) else{
            print("Input A number")
            dayInput.text = "Input a number"
            return
        }
        
        if (days < 2 || days > 14){
            print("Invalid Number")
            dayInput.text = "Invalid number"
            return
        }
        
        let session = URLSession.shared
        
        let urlString = "https://disease.sh/v3/covid-19/nyt/states?lastdays=\(String(days))"

        let url = URL(string: urlString)!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for state in jsonArr {
                //let stateName = state["state"] as! String
                let caseNum = state["cases"] as! Int
                let deathNum = state["deaths"] as! Int
                self.inputCases.append(caseNum)
                self.inputDeaths.append(deathNum)
            }
        }
        
        task.resume()
        
        if (inputCases.count == 0 || inputDeaths.count == 0){
            resultErrorMessage.text = "Please Try Again"
            return
        }else{
            resultErrorMessage.text = ""
            resultCasesLabel.text = "Change in cases: \(String(todayCases[index + 55] - inputCases[index]))"
            resultDeathsLabel.text = "Change in deaths: \(String(todayDeaths[index + 55] - inputDeaths[index]))"
            
            
            inputCases.removeAll()
            inputDeaths.removeAll()
        }

    }
    
    @IBAction func favoriteButton(_ sender: Any) {
//        let screen = FavoriteStateViewController()
        //sending info for one state
        
//        FavoriteStateViewController.stateNames.append(self.stateName)
//        FavoriteStateViewController.todayCases.append(self.todayCases[self.index + 55] - self.todayCases[self.index])
//        FavoriteStateViewController.todayDeaths.append(self.todayDeaths[self.index + 55] - self.todayDeaths[self.index])
//        FavoriteStateViewController.allTimeCases.append(self.todayCases[self.index + 55])
//        FavoriteStateViewController.allTimeDeaths.append(self.todayDeaths[self.index + 55])

        
        //send indexes of fav states
        //mainVC will provide the arrays to calculate everything when mainVC is loaded
        FavoriteStateViewController.index.append(self.index)
        
        
        print("Appending")
        
        //need this to reload the data in FavoriteStatesViewController
        let notificationNme = NSNotification.Name("NotificationIdf")
        NotificationCenter.default.post(name: notificationNme, object: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.stateName)
        print(index)
        print(todayCases)
        // Do any additional setup after loading the view.
        
        stateNameLabel.text = stateName
        allTimeCasesLabel.text = "Cases: \(String(todayCases[index + 55]))"
        allTimeDeathsLabel.text = "Deaths: \(String(todayDeaths[index + 55]))"
        todayCasesLabel.text = "Cases Today: \(String(todayCases[index + 55] - todayCases[index]))"
        todayDeathsLabel.text = "Deaths Today: \(String(todayDeaths[index + 55] - todayDeaths[index]))"
        resultErrorMessage.text = ""
        
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
