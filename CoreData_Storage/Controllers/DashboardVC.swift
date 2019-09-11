//
//  DashboardVC.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    //MARK:- IBOUTLET VARIABLE
    
    //MARK:- VARIABLE
    
    //MARK:- VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK:- BUTTON ACTIONMETHODS
    @IBAction func btnAddClick(_ sender: Any) {
        self.performSegue(withIdentifier: "segExpenceVC", sender: true)
        
    }
    
    @IBAction func btnMinusClick(_ sender: Any) {
        self.performSegue(withIdentifier: "segExpenceVC", sender: false)
    }
    
    @IBAction func btnGotoListClick(_ sender: Any) {
        self.performSegue(withIdentifier: "segTransactionVC", sender: true)
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
extension DashboardVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segExpenceVC" {
            let aDestination = segue.destination as! ExpenceVC
            let transaction = TransactionType(context: PersistanceManager.shared.context)
            if let isAdd = sender as? Bool, isAdd {
               transaction.name = TransType.add.rawValue
            }else{
               transaction.name = TransType.minus.rawValue
            }
            aDestination.transationType = transaction
        }
    }
}
