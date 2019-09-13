//
//  TransactionVC.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit

class TransactionVC: UIViewController {
    
    //MARK:- IBOUTLET VARIABLE
    @IBOutlet weak var tblTransaction : UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK:- VARIABLE
    private var arrTransactions = [Transactions]()
    let persistanceManager = PersistanceManager.shared
    
    //MARK:- VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTransaction.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
        tblTransaction.estimatedRowHeight = 70
        tblTransaction.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrTransactions = persistanceManager.fetch(Transactions.self)
        self.tblTransaction.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    //MARK:- BUTTON ACTIONMETHODS
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
extension TransactionVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        let data = self.arrTransactions[indexPath.row]
        cell.lblDate.text = data.date.display
        cell.lblAumount.text = "$ \(Int(data.amount).format()!)"
        cell.lblCategory.text = "\(data.categorys.category_name)"
        cell.lblNote.text = data.transactiontypes.transaction_ID
        cell.isIncome = data.transactiontypes.name == TransType.add.rawValue ? true : false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
