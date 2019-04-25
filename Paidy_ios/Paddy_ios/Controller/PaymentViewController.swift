//
//  PaymentViewController.swift
//  Paidy_ios
//
//  Created by Tristate on 20/04/19.
//  Copyright © 2019 Tristate. All rights reserved.


import UIKit
import WebKit
class PaymentViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK:- Variables
    var paymentInforamtion : PaymentInfo!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: View Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        self.loadPaidyHtmlFile()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK:- IBActions
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Loading HTML File
    
    func loadPaidyHtmlFile(){
        if appDelegate.accountType == .live {
         self.webView?.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "paidy_Live", ofType: "html")!)))
        }else{
          self.webView?.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "paidy_Sandbox", ofType: "html")!)))
        }
    }
 
    // Convert Json String To Json Dictionary
    
    func convertToDictionary(text: String?) -> [String: Any]? {
        guard let text = text else {
            return [:]
        }
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func showAlert(title:String,msg:String,okbtnTitle:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okbtnTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: WKWebview Delegate Function

extension PaymentViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let requestScheme = webView.url?.scheme
        let requestHost = webView.url?.host
        let jsonString = webView.url?.fragment?.removingPercentEncoding
        print("\(String(describing: requestScheme)) \(String(describing: requestHost))")
        let jsonDictionary = convertToDictionary(text: jsonString)
        if let dict = jsonDictionary{
            if dict.count > 0{
                if let token = dict["token"] as? String{
                     print(token)
                    
                    self.showAlert(title: "Paidy", msg: "Payment_Token: \(token)", okbtnTitle: "OK")
                }
            }
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
        if(navigationAction.navigationType == .formSubmitted){
            if navigationAction.request.url != nil{
                print(navigationAction.request.url!)
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var payload = [String:Any]()
        payload  = ["store_name":"Paidy Demo","buyer" :["name1" :paymentInforamtion.fullname, "name2" :paymentInforamtion.displayname, "dob" :paymentInforamtion.dob,"email" : paymentInforamtion.email,"phone":paymentInforamtion.phone],"shipping_address":["line1":paymentInforamtion.addressline1,"line2":paymentInforamtion.addressline2,"city":paymentInforamtion.city,"state":paymentInforamtion.state,"zip":paymentInforamtion.zipcode]]
        
        let data2: Data? = try? JSONSerialization.data(withJSONObject: payload, options: [])
        let strPayload = String(data: data2!, encoding: String.Encoding.utf8)
        let strdata = "paidyPaynew(\(strPayload!))"
        webView.evaluateJavaScript(strdata, completionHandler: nil)
    }
}
