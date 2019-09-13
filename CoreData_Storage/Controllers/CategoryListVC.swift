//
//  CategoryListVC.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit

protocol CategoryDelegate {
    func didSelect(category:Categories)
}

enum TransType : String {
    case add = "Income"
    case minus = "Expense"
}

class CategoryListVC: UIViewController {

    //MARK:- IBOUTLET VARIABLE
    @IBOutlet weak var tblJobs : UITableView!
    @IBOutlet weak var lblTitle: UILabel!

    //MARK:- VARIABLE
    private var arrJobs = [Categories]()
    var delegate : CategoryDelegate?
    let persistanceManager = PersistanceManager.shared
    
    //MARK:- VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        tblJobs.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tblJobs.estimatedRowHeight = 55
        tblJobs.rowHeight = UITableView.automaticDimension
        
        let category = Categories(context: PersistanceManager.shared.context)
        category.category_name = "Fuel"
        let tansactionType = TransactionType(context: persistanceManager.context)
        tansactionType.name = TransType.add.rawValue
        category.categoryTransactiontype = tansactionType        
        persistanceManager.save()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrJobs = persistanceManager.fetch(Categories.self)
        self.tblJobs.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    //MARK:- BUTTON ACTIONMETHODS
    @IBAction func btnSaveClick(_ sender: Any) {
        
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- CALLER METHODS
    
    
    //MARK:- CUSTOM METHODS
    
    
    //MARK:- VIEW CYCYLE END
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
//MARK: - EXTENTION OF TABLEVIEW DELEGATE AND DATA SOURCE
extension CategoryListVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.lblTitle?.text = self.arrJobs[indexPath.row].category_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            self.delegate?.didSelect(category: self.arrJobs[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
    }
}
