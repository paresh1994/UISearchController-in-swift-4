//
//  ViewController.swift
//  SearchViewController
//
//  Created by iDeveloper2 on 27/03/18.
//  Copyright © 2018 iDeveloper2. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let dataList = [["name":"David Smith","email":"david@example.com"],
                    ["name":"Kevin John","email":"kjohn@example.com"],
                    ["name":"Jacob Brown","email":"jacobb@example.com"],
                    ["name":"Paul Johnson","email":"johnsonp@example.com"],
                    ["name":"Sam William","email":"willsam@example.com"],
                    ["name":"Brian Taylor","email":"btaylor@example.com"],
                    ["name":"Charles Smith","email":"charless@example.com"],
                    ["name":"Andrew White","email":"awhite@example.com"],
                    ["name":"Matt Thomas","email":"mthomas@example.com"],
                    ["name":"Michael Clark","email":"clarkm@example.com"]]
    
    var filteredList = [[String:String]]()
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search Controller"
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.scopeButtonTitles = ["All", "Name", "Email"]
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
        
        self.navigationItem.searchController = self.searchController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchForText(_ searchText:String?, scope:Int) {
        
        if let text = searchText {
            
            if (text.isEmpty == false)
            {
                if (scope == 0)
                {
                    self.filteredList = self.dataList.filter({ (obj : [String : String]) -> Bool in
                        
                        if obj["name"]?.contains(text) == true || obj["email"]?.contains(text) == true {
                            return true
                        } else {
                            return false
                        }
                    })
                }
                else if (scope == 1)
                {
                    self.filteredList = self.dataList.filter({ (obj : [String : String]) -> Bool in
                        
                        if obj["name"]?.contains(text) == true || obj["email"]?.contains(text) == true {
                            return true
                        } else {
                            return false
                        }
                    })
                }
                else if (scope == 2)
                {
                    self.filteredList = self.dataList.filter({ (obj : [String : String]) -> Bool in
                        
                        if obj["email"]?.contains(text) == true {
                            return true
                        } else {
                            return false
                        }
                    })
                }
            }
            else
            {
                self.filteredList = self.dataList;
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchForText(searchController.searchBar.text, scope: searchController.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
    
    
    // MARK: - UITableview datasourze
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return self.filteredList.count
        }else{
            return self.dataList.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if self.searchController.isActive {
            cell.textLabel?.text = self.filteredList[indexPath.row]["name"]
            cell.detailTextLabel?.text = self.filteredList[indexPath.row]["email"]
        }else {
            cell.textLabel?.text = self.dataList[indexPath.row]["name"]
            cell.detailTextLabel?.text = self.dataList[indexPath.row]["email"]
        }
        return cell
    }
    
    
}

