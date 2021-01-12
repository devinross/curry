//
//  CellsController.swift
//  Examples
//
//  Created by Devin Ross on 1/12/21.
//  Copyright © 2021 Devin Ross. All rights reserved.
//

import Foundation
import curry

class CellsController : TKTableViewController{
	
	
	var cells : [UITableViewCell] = []
	
	
	override func loadView() {
		super.loadView()
		
		let fieldCell = TKTextFieldCell(style: .default, reuseIdentifier: "field")
		fieldCell.textField.placeholder = "Field"
		fieldCell.textField.text = "Field"

		let switchCell = TKSwitchCell(style: .default, reuseIdentifier: "switch")
		switchCell.textLabel?.text = "Field"
		
		self.cells = [fieldCell,switchCell]
		
		
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.cells.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cells[indexPath.row]
	}


	
	
	
	
}
