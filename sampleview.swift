//
//  sampleview.swift
//  AutoComplete
//
//  Created by 이준영 on 2020/11/09.
//

import UIKit
import RealmSwift

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.SearchView.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(self.SearchView.text!)
        print(DataFrame().FindData(filter: self.SearchView.text!))
        MakeBtn(array : DataFrame().FindData(filter: self.SearchView.text!))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.SearchView.showsCancelButton = false
        if(self.SearchView.text == ""){
        }
        self.SearchView.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DataFrame().PutData(data: self.SearchView.text!)
        self.SearchView.showsCancelButton = false
        self.SearchView.resignFirstResponder()
    }
    
}
