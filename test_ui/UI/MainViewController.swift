//
//  MainViewController.swift
//  test_ui
//
//  Created by Dimas on 26.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

	var items:[PostItem] = []
	var dataProvider:DataProvider!
	var isLoading:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		self.tableView.register(PostCell.self, forCellReuseIdentifier: "post_cell")
		self.tableView.separatorStyle = .none
		self.tableView.tableFooterView = UIView()
		self.dataProvider = DataProvider(from: Bundle.main.path(forResource: "data", ofType: "json") ?? "")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.loadData()
	}
	func loadData(){
		if isLoading{
			return
		}
		isLoading = true
		dataProvider.getPosts {[weak self] (posts) in
			guard let self = self else{
				return
			}
			DispatchQueue.main.async {
				self.updateItems(posts)
			}
		}
	}
	func updateItems(_ items:[PostItem]) {
		self.items = items
		self.tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post_cell", for: indexPath)
		if let cell = cell as? PostCell{
			cell.item = self.items[indexPath.row]
		}
        return cell
    }
    
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
}
