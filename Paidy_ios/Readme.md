Paidy is a payment gateway which supports in japan.
Paidy is a fast and secure way to check out online. It allows your consumers to easily make purchases using only an email address and phone number.
 
Paidy IOS and Android SDK are available but that was deprecated from last few years. If we have to use Paidy on mobile side then we have to use their javascript SDK.
 
Using this SDK you will get a payment token that you have to pass in the backend. In the backend side, you can do payment using below API which paidy is providing. In the demo, we have generated token that will be use for future payment as well. means no need to generate each and every time.
Please use below API for payment capture after generating a token from the mobile side.
 
https://paidy.com/docs/en/payments.html
 
Sandbox mode:
 
Step 1: Download source code
Step 2: Replace your sandbox environment key in paidy_snadbox.html file. 
var config = {
                          // Put your sandbox enviorment key
       "api_key": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                                                      
                                                     
                                                     
Step3 : Set sandbox mode for accountType in AppDelegate file.
                                                      
var accountType : PaidyPaymentType = .sandbox
                                                      
 Step 4: Run and add all the information then click on pay with paidy button
                                                      
                                                      
Live mode:
                                                      
Step 1: Replace your sandbox environment key in paidy_Live.html file. 
Step 2: Replace your sandbox environment key in paidy_snadbox.html file. 
var config = {
                          // Put your Live enviorment key
                          "api_key": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",     
Step 3: Set sandbox mode for accountType in AppDelegate file.
                                                 
var accountType : PaidyPaymentType = .live
                                                      
Step 4: Run and add all the information then click on pay with paidy button
                                                      
Sandbox mode testing:
 Please use below information for checking payment in sandbox environment 
 Email  =  "successful.payment@paidy.com"
 Phone =  "08000000001"
 Verification code =  8888

