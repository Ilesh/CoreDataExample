//
//  IPDatePicker.swift
//  
//
//  Created by macmini on 22/08/18.
//  Copyright © 2018 Recritd Ltd. All rights reserved.
//
import UIKit

protocol IPDataPickerDelegate: class {
    func datePicker(_ amDatePicker: IPDataPicker, didSelect date: Date)
    func datePickerDidCancelSelection(_ amDatePicker: IPDataPicker)
}

class IPDataPicker: UIView {
    
    // MARK: - Default Configuration
    struct Config {
        
        fileprivate let contentHeight: CGFloat = 200
        fileprivate let bouncingOffset: CGFloat = 0
        
        var headerHeight: CGFloat = 44.0
        
        var startDate: Date?
        var MaxDate: Date?
        var MinDate: Date?
        
        var btnDoneTitle = "Done"
        var btnCancelTitle = "Cancel"
        
        var animationDuration: TimeInterval = 0.35
        
        var contentBackgroundColor: UIColor = UIColor.white
        var headerBackgroundColor: UIColor = Theme.color.primaryTheme
        var btnDoneColor: UIColor = Theme.color.text
        var btnCancelColor: UIColor = Theme.color.text
        var overlayBackgroundColor: UIColor = UIColor.clear
    }
    
    var config = Config()
    var arrFirstRecords : [String] = []
    var arrSecondRecords : [String] = []
    
    weak var delegate: IPDataPickerDelegate?
    
    //FOR THE ONE COMPONANT
    typealias dataPickerDidSelectDate = (_ selectedIndex : Int , _ isCancel : Bool) -> Void
    var pickerBlock : dataPickerDidSelectDate?
    
    //FOR THE TWO COMPONANT
    typealias dataPickerDidSelectComponats = (_ firstIndex : Int, _ secondIndex : Int  , _ isCancel : Bool) -> Void
    var pickerComponats : dataPickerDidSelectComponats?
    
    // MARK: - IBOutlets
    @IBOutlet weak var aPicker: UIPickerView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var bottomConstraint: NSLayoutConstraint!
    var overlayButton: UIButton!
    
    fileprivate var objParentVC : UIViewController?
    
    
    // MARK: - Init
    static func getFromNib() -> IPDataPicker {
        return UINib.init(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self, options: nil).last as! IPDataPicker
    }
    
    // MARK: - Private Method
    
    
    /// Method will set default confuguration for Date Picker
    ///
    /// - Parameter parentVC: Object of ViewController in which you want to Display Date Picker
    fileprivate func setup(_ parentVC: UIViewController) {
        
        // Loading configuration
        
        /*if let startDate = config.startDate {
            datePicker.date = startDate
        }
        
        if let maxdate = config.MaxDate {
            datePicker.maximumDate = maxdate
        }
        
        if let minDate = config.MinDate {
            datePicker.minimumDate = minDate
        }*/
        
        headerViewHeightConstraint.constant = config.headerHeight
        
        btnDone.setTitle(config.btnDoneTitle, for: UIControl.State())
        btnCancel.setTitle(config.btnCancelTitle, for: UIControl.State())
        
        btnDone.setTitleColor(config.btnDoneColor, for: UIControl.State())
        btnCancel.setTitleColor(config.btnCancelColor, for: UIControl.State())
        
        headerView.backgroundColor = config.headerBackgroundColor
        backgroundView.backgroundColor = config.contentBackgroundColor
        
        // Overlay view constraints setup
        
        overlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayButton.backgroundColor = config.overlayBackgroundColor
        overlayButton.alpha = 0
        
        overlayButton.addTarget(self, action: #selector(btnCancelClick(_:)), for: .touchUpInside)
        
        if !overlayButton.isDescendant(of: parentVC.view) { parentVC.view.addSubview(overlayButton) }
        
        overlayButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentVC.view.addConstraints([
            NSLayoutConstraint(item: overlayButton, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .top, relatedBy: .equal, toItem: parentVC.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        
        // Setup picker constraints
        
        frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: config.contentHeight + config.headerHeight)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        if !isDescendant(of: parentVC.view) { parentVC.view.addSubview(self) }
        
        parentVC.view.addConstraints([
            bottomConstraint,
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        addConstraint(
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.height)
        )
        
        move(false)
        
    }
    
    
    /// Method will help in animating the Date Picker on screen
    ///
    /// - Parameter isUp: Pass true if you want to show display animation for Date Picker or pass false if you want to hide date picker
    fileprivate func move(_ isUp: Bool) {
        bottomConstraint.constant = isUp ? config.bouncingOffset : config.contentHeight + config.headerHeight
    }
    
    
    // MARK: - Button Click Methods
    
    /// Button Done Click Method
    ///
    /// - Parameter sender: Object of Button Done
    @IBAction func btnDoneClick(_ sender: UIButton) {
        if arrFirstRecords.count > 0 && arrSecondRecords.count > 0 {
            let aFirstIndex = aPicker.selectedRow(inComponent: 0)
            let aSecondIndex = aPicker.selectedRow(inComponent: 1)
            pickerComponats?(aFirstIndex,aSecondIndex,false)
        }else{
            let index = aPicker.selectedRow(inComponent: 0)
            pickerBlock?(index , false)
            //delegate?.datePicker(self, didSelect:Date())
        }
        dismiss()
    }
    
    
    /// Button Cancel Click Method
    ///
    /// - Parameter sender: Object of Button Cancel
    @IBAction func btnCancelClick(_ sender: UIButton) {
        if arrFirstRecords.count > 0 && arrSecondRecords.count > 0 {
            let aFirstIndex = aPicker.selectedRow(inComponent: 0)
            let aSecondIndex = aPicker.selectedRow(inComponent: 1)
            pickerComponats?(aFirstIndex,aSecondIndex,true)
        }else{
            let index = aPicker.selectedRow(inComponent: 0)
            pickerBlock?(index , true)
            delegate?.datePickerDidCancelSelection(self)
        }
        dismiss()
    }
    
    
    // MARK: - Public Methods
    
    
    /// Method will display Date Picker with Animation
    ///
    /// - Parameters:
    ///   - parentVC: Object of controller in which you want to display Date Picker
    ///   - withCompletionBlock: Completion block which will be called when user tap on Done / Cancel Button
    func show(_ _arrRecords:[String], _ parentVC : UIViewController , withCompletionBlock : @escaping dataPickerDidSelectDate) {
        pickerBlock = withCompletionBlock
        self.arrFirstRecords = _arrRecords
        show(parentVC)
        aPicker.reloadAllComponents()
    }
    
    
    /// Method will display Date Picker with Animation
    ///
    /// - Parameters:
    ///   - parentVC: Object of controller in which you want to display Date Picker
    ///   - withCompletionBlock: Completion block which will be called when user tap on Done / Cancel Button
    func showTwoCompont(_ _arrFirst:[String], _arrSecond:[String], _ parentVC : UIViewController , withCompletionBlock : @escaping dataPickerDidSelectComponats) {
        pickerComponats = withCompletionBlock
        self.arrFirstRecords = _arrFirst
        self.arrSecondRecords = _arrSecond
        show(parentVC)
        aPicker.reloadAllComponents()
    }
    
    
    /// Method will display Date Picker with Animation
    ///
    /// - Parameters:
    ///   - parentVC: Object of controller in which you want to display Date Picker
    ///   - completion: Block will be called when Date Picker will be displayed in the screen. You can do additional operations here if you want after displaying date picker.
    
    func show(_ parentVC: UIViewController, completion: (() -> ())? = nil) {
        
        parentVC.view.endEditing(true)
        
        objParentVC = parentVC
        
        setup(parentVC)
        move(true)
        
        UIView.animate(
            withDuration: config.animationDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
                
                parentVC.view.layoutIfNeeded()
                self.overlayButton.alpha = 1
                
        }, completion: { (finished) in
            completion?()
        }
        )
        
    }

    /// Method will dismiss the
    ///
    /// - Parameter completion: Completion block will be called after Picker is dismissed from view.
    func dismiss(_ completion: (() -> ())? = nil) {
        
        move(false)
        
        UIView.animate(
            withDuration: config.animationDuration, animations: {
                
                self.layoutIfNeeded()
                self.objParentVC?.view.layoutIfNeeded()
                self.overlayButton.alpha = 0
                
        }, completion: { (finished) in
            completion?()
            self.removeFromSuperview()
            self.overlayButton.removeFromSuperview()
        }
        )
    }
}

extension IPDataPicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if arrFirstRecords.count > 0 && arrSecondRecords.count > 0 {
           return 2
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return arrFirstRecords.count
        }else{
            return arrSecondRecords.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
             return arrFirstRecords[row]
        }else{
            return arrSecondRecords[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //arrayFruits[row]
    }
}
