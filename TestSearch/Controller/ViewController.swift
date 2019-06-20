//
//  ViewController.swift
//  TestSearch
//
//  Created by Andrey Petrovskiy on 6/20/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topRatedWidth: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var alphabetTableView: UITableView!
    @IBOutlet weak var topRatedTableView: UITableView!
    var alphabetRepos: [Repo] = []{
        didSet{
            self.alphabetTableView.reloadData()
        }
    }
    var topRatedRepos: [Repo] = []{
        didSet{
            self.topRatedTableView.reloadData()
        }
    }
    var sortType: SortType = .alphabet
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         fetchData()
        alphabetTableView.dataSource = self
        alphabetTableView.delegate = self
        topRatedTableView.delegate = self
        topRatedTableView.dataSource = self
        let nib = UINib.init(nibName: "RatedCell", bundle: nil)
        topRatedTableView.register(nib, forCellReuseIdentifier: "ratedCell")
        searchBar.delegate = self
       
        
    }
    func fetchData(){
        alphabetRepos = CoreDataSingleton.shared.fetchData().sorted{$0.name! < $1.name!}
        topRatedRepos = CoreDataSingleton.shared.fetchData().sorted{$0.stars < $1.stars}
        alphabetTableView.reloadData()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        switch UIDevice.current.orientation{
        case .portrait:
           topRatedWidth.constant = 0
        case .portraitUpsideDown:
           topRatedWidth.constant = view.frame.width / 2
        case .landscapeLeft:
             topRatedWidth.constant = view.frame.width / 2
        case .landscapeRight:
            topRatedWidth.constant = view.frame.width / 2
        default:
           topRatedWidth.constant = 0
        }
        
       
    }
    
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == alphabetTableView{
        return alphabetRepos.count
        } else {
        return topRatedRepos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == alphabetTableView{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CustomCell else { return UITableViewCell()}
            cell.repoNameLbl.text = alphabetRepos[indexPath.row].name
            cell.routeLbl.text = alphabetRepos[indexPath.row].link
            cell.avatarImageVIew.image = UIImage(data:alphabetRepos[indexPath.row].avatar! , scale: 0)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ratedCell", for: indexPath) as? RatedCell else { return UITableViewCell()}
            cell.repoNameLbl.text = topRatedRepos[indexPath.row].name
            cell.routeLbl.text = topRatedRepos[indexPath.row].link
            cell.avatarImageVIew.image = UIImage(data:topRatedRepos[indexPath.row].avatar! , scale: 0)
            return cell
        }
        
       
    }
    
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Web") as! WebViewController
        vc.url = alphabetRepos[indexPath.row].link
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        alphabetRepos = []
        APIManager().getData(with: .stars, with: searchBar.text ?? "") { (finish) in
            if finish{
                self.alphabetRepos = CoreDataSingleton.shared.fetchData().sorted{$0.name! < $1.name!}
                self.topRatedRepos =  CoreDataSingleton.shared.fetchData().sorted{$0.stars < $1.stars}
                OperationQueue.main.addOperation {
                     self.alphabetTableView.reloadData()
                }
               
            }
        }
        
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
}

