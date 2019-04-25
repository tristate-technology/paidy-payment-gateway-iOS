//
//  PaymentDetailController.swift
//  Paddy_ios
//
//  Created by Tristate on 20/04/19.
//  Copyright © 2019 Tristate. All rights reserved.


import UIKit
import IQKeyboardManagerSwift
class PaymentDetailController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var txtFullname: CustomizedTextfield!
    @IBOutlet weak var txtDisplyname: CustomizedTextfield!
    @IBOutlet weak var txtDateofbirth: CustomizedTextfield!
    @IBOutlet weak var txtEmail: CustomizedTextfield!
    @IBOutlet weak var txtPhone: CustomizedTextfield!
    @IBOutlet weak var txtAdressLine1: CustomizedTextfield!
    @IBOutlet weak var txtAddressLine2: CustomizedTextfield!
    @IBOutlet weak var txtCity: CustomizedTextfield!
    @IBOutlet weak var txtState: CustomizedTextfield!
    @IBOutlet weak var txtZipcode: CustomizedTextfield!
    @IBOutlet weak var btnPay: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK:- Variables
    let datePicker = UIDatePicker()
    var paymentinfo : PaymentInfo!
    
    //MARK: View Life Cycle methods
    override func viewDidLoad(){
        super.viewDidLoad()
         self.showDatePicker()
        self.title = "Paidy"
        btnPay.layer.cornerRadius = btnPay.frame.size.height / 2
        btnPay.layer.masksToBounds = true
    }
    
    //MARK: Date Picker methods
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePicker.maximumDate = Date()
        txtDateofbirth.inputView = datePicker
        
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDateofbirth.text = formatter.string(from: datePicker.date)
    }
    
    //MARK: Custom button methods
    @IBAction func btnPayAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if self.validation() {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let paymentVC = sb.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
            
            let dictInformation : [String:Any] = ["fullname":txtFullname.text ?? "","displayname":txtDisplyname.text ?? "","dob":txtDateofbirth.text ?? "","email":txtEmail.text ?? "","phone" :txtPhone.text ?? "","addressline1":txtAdressLine1.text ?? "","addressline2" : txtAddressLine2.text ?? "", "city":txtCity.text ?? "","state": txtState.text ?? "","zipcode": txtZipcode.text ?? ""]
            
            paymentinfo = PaymentInfo.init(fromDictionary: dictInformation)
            
            paymentVC.paymentInforamtion = paymentinfo
            navigationController?.pushViewController(paymentVC, animated: true)
        }
       
    }
    //MARK: Show Alert view
    func showAlert(title:String,msg:String,okbtnTitle:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okbtnTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Validation methods
    
    func validation() -> Bool{
        
        if let strFullName = txtFullname.text, strFullName.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter fullname", okbtnTitle: "OK")
            return false
        }else if let strDisplayName = txtDisplyname.text,strDisplayName.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
              self.showAlert(title:"", msg: "Please enter display name", okbtnTitle: "OK")
             return false
        }else if let strDateOfBirth = txtDateofbirth.text,strDateOfBirth.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter date of birth", okbtnTitle: "OK")
            return false
        }else if let strEmail = txtEmail.text,strEmail.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter email", okbtnTitle: "OK")
            return false
        }else if let strEmail = txtEmail.text,!self.isValidEmail(testStr: strEmail.trimmingCharacters(in: .whitespacesAndNewlines)){
            self.showAlert(title:"", msg: "Please enter valid email", okbtnTitle: "OK")
            return false
        }else if let strPhoneNumber = txtPhone.text,strPhoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter phone number", okbtnTitle: "OK")
            return false
        }else if let strPhoneNumber = txtPhone.text,strPhoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).count <= 9{
            self.showAlert(title:"", msg: "Please enter valid phone number", okbtnTitle: "OK")
            return false
        }else if let strAddressLine1 = txtAdressLine1.text,strAddressLine1.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
             self.showAlert(title:"", msg: "Please enter address line1", okbtnTitle: "OK")
            return false
        }else if let strAddressLine2 = txtAddressLine2.text,strAddressLine2.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter address line2", okbtnTitle: "OK")
            return false
        }else if let strCity = txtCity.text,strCity.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter city", okbtnTitle: "OK")
            return false
        }else if let strState = txtState.text,strState.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter state", okbtnTitle: "OK")
            return false
        }else if let strZipCode = txtZipcode.text,strZipCode.trimmingCharacters(in: .whitespacesAndNewlines).count <= 0{
            self.showAlert(title:"", msg: "Please enter zipcode", okbtnTitle: "OK")
            return false
        }
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
