//
//  ExpenceVC.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class ExpenceVC: UIViewController {

    //MARK:- IBOUTLET VARIABLE
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtAmount: IPTextField!
    @IBOutlet weak var txtDate: IPTextField!
    @IBOutlet weak var txtCategory: IPTextField!
    @IBOutlet weak var txtNote: RSKPlaceholderTextView!
    @IBOutlet weak var btnSave: IPButton!
    
    //MARK:- VARIABLE
    var selectedDate : Date! {
        didSet{
            self.txtDate.text = selectedDate.dateTimeString(withFormate: "dd / mm/ yyyy")
        }
    }
    
    var selectedCategory : Categories? {
        didSet {
            self.txtCategory.text = selectedCategory?.category_name ?? ""
        }
    }
    
    var transationType : TransactionType!
    
    //MARK:- VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNote.placeholder = "Enter a note..."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.selectedDate = Date()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    //MARK:- BUTTON ACTIONMETHODS
    @IBAction func btnSaveClick(_ sender: Any) {
        self.validateInformation()
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- CUSTOM METHODS
    private func validateInformation() {
        let strAmount = txtAmount.text!.trimmingCharacters(in: .whitespaces)
        guard strAmount.count > 0 else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Please enter amount.", completion: nil)
            return
        }
        
        guard strAmount.toDouble() > 0 else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Please enter amount graterthan zero", completion: nil)
            return
        }
        
        guard self.selectedCategory != nil else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Please enter amount graterthan zero", completion: nil)
            return
        }
        
        let transaction = Transactions(context: PersistanceManager.shared.context)
        transaction.date = self.selectedDate as NSDate
        transaction.note = txtNote.text
        transaction.amount = (txtAmount.text ?? "0").toDouble()
        transaction.categorys = selectedCategory!
        transaction.transactiontypes = self.transationType
        
        PersistanceManager.shared.save()
        UIAlertController.showAlertWithOkButton(self, aStrMessage: "Record saved successfully.") { (index, str) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
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
extension ExpenceVC : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtAmount {
            return true
        }else if textField == txtDate {
            Global().delay(delay: 0.1) {
               let picker = IPDatePicker.getFromNib()
               picker.datePicker.date = Date()
                picker.show(self, withCompletionBlock: { (date, isCancel) in
                    if !isCancel {
                        self.selectedDate = date
                    }
                })
            }
        }else if textField == txtCategory {
            self.performSegue(withIdentifier: "segCategoryListVC", sender: nil)
        }
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
}

extension ExpenceVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segCategoryListVC" {
            let aDestination = segue.destination as! CategoryListVC
            aDestination.delegate = self
        }
    }
}
extension ExpenceVC : CategoryDelegate {
    func didSelect(category: Categories) {
        self.selectedCategory = category
    }
}
