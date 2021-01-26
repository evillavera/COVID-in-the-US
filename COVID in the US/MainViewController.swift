//
//  MainViewController.swift
//  COVID in the US
//
//  Created by Erik Villavera on 1/21/21.
//

//work on segue and the next page

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var info = [[String:Any]]()
//    var stateNames = [[String:Any]]()
    var stateNames: [String] = []
    var todayCases: [Int] = []
    var todayDeaths: [Int] = []
    
    var states = [String:Any]()
    
    @IBOutlet weak var statesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        statesTableView.dataSource = self
        statesTableView.delegate = self

        // Do any additional setup after loading the view.
        
        //let state = "new jersey"
        let state = "new%20york"
        let days = "2"
        print("hello")
        
        let session = URLSession.shared
        
//        let urlString = "https://disease.sh/v3/covid-19/nyt/states/\(state)?lastdays=\(days)"
        let urlString = "https://disease.sh/v3/covid-19/nyt/states?lastdays=2"

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
                let stateName = state["state"] as! String
                let caseNum = state["cases"] as! Int
                let deathNum = state["deaths"] as! Int
                self.stateNames.append(stateName)
                self.todayCases.append(caseNum)
                self.todayDeaths.append(deathNum)
//                print(self.stateNames)
//                print(self.stateNames.count)
//                print(self.cases)
//                print(self.deaths)
                
                //send all this info to FavVC
                FavoriteStateViewController.stateNames.append(stateName)
                FavoriteStateViewController.todayCases.append(caseNum)
                FavoriteStateViewController.todayDeaths.append(deathNum)
            }
        }
        
        self.statesTableView.reloadData()
        task.resume()
//        print("Our statenames")
//        print(self.stateNames)
        self.statesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell") as! StateCell
        
//        print(stateNames)
        if (stateNames.count == 0 || todayCases.count == 0 || todayDeaths.count == 0){
            self.viewDidLoad()
            return cell
        }else{
            let state = stateNames[indexPath.item]
            let caseNum = todayCases[indexPath.item + 55] - todayCases[indexPath.item]
            let deathNum = todayDeaths[indexPath.item + 55] - todayDeaths[indexPath.item]
            var status: String
            if caseNum > 0 {
                status = "Increasing"
            }else if caseNum < 0  {
                status = "Decreasing"
            }else{
                status = "Need More Information"
            }
//            print("cell")
//            print(state)
    //        print(caseNum)
    //        print(deathNum)
            
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
        let stateName = stateNames[indexPath.row]
//        let caseNum = todayCases[indexPath.row]
        //Pass the selected movie to the Details VC
        
        let stateDetailViewController = segue.destination as! StateDetailViewController
        
        stateDetailViewController.index = indexPath.row
        stateDetailViewController.stateName = stateName
        stateDetailViewController.todayCases = self.todayCases
        stateDetailViewController.todayDeaths = self.todayDeaths
        
        statesTableView.deselectRow(at: indexPath, animated: true)
    }

}







//
////
////  MainViewController.swift
////  COVID in the US
////
////  Created by Erik Villavera on 1/21/21.
////
//
//import UIKit
//
//class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var info = [[String:Any]]()
////    var stateNames = [[String:Any]]()
//    var stateNames: [String] = []
//
//    var states = [String:Any]()
//
//    @IBOutlet weak var statesTableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        statesTableView.dataSource = self
//        statesTableView.delegate = self
//
//        // Do any additional setup after loading the view.
//
//        //let state = "new jersey"
//        let state = "new%20york"
//        let days = "2"
//        print("hello")
//
//        let session = URLSession.shared
//
////        let urlString = "https://disease.sh/v3/covid-19/nyt/states/\(state)?lastdays=\(days)"
//        let urlString = "https://disease.sh/v3/covid-19/nyt/states?lastdays=1"
//
//        let url = URL(string: urlString)!
//
//        let task = session.dataTask(with: url) { data, response, error in
//
//            if error != nil || data == nil {
//                print("Client error!")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                print("Server error!")
//                return
//            }
//
//            guard let mime = response.mimeType, mime == "application/json" else {
//                print("Wrong MIME type!")
//                return
//            }
//
//            let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
//            for state in jsonArr {
//                let stateName = state["state"] as! String
//                self.stateNames.append(stateName)
//                print(stateName)
////                    self.stateNames.append(stateName)
//            }
////                self.info = json[]
////                print(json)
//            print(self.stateNames)
//
////            do {
//////                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSMutableArray
////                let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
////                for state in jsonArr {
////                    let stateName = state["state"] as! String
////                    self.stateNames.append(stateName)
////                    print(stateName)
//////                    self.stateNames.append(stateName)
////                }
//////                self.info = json[]
//////                print(json)
////                print(self.stateNames)
////
//////                self.info = json as! [[String : Any]]
//////                self.info = json as! [String:Any]
//////                self.info = json as! NSArray
////
////
////
////            } catch {
////                print("JSON error: \(error.localizedDescription)")
////            }
//        }
//        print("Our statenames")
//        print(self.stateNames)
//        self.statesTableView.reloadData()
//        task.resume()
//
//        self.statesTableView.reloadData()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.info.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell") as! StateCell
//
//        let state = stateNames[indexPath.item]
//        print("cell")
//        print(state)
//
////        let stateName = info["state"] as! String
////        let movie = movies[indexPath.row]
////        let title = movie["title"] as! String
////        let synopsis = movie["overview"] as! String
//
////        cell.titleLabel.text = title
////        cell.synopsisLabel.text = synopsis
////
////        let baseUrl = "https://image.tmdb.org/t/p/w185"
////        let posterPath = movie["poster_path"] as! String
////        let posterUrl = URL(string: baseUrl + posterPath)
////
////        //cell.posterView.af_setImage(withURL: posterUrl!)
////        cell.posterView.downloaded(from: posterUrl!)
//
//        return cell
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
