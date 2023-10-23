// import 'dart:convert';
// import 'dart:io';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
//
// void main() {
//   runApp(const MerchantApp());
// }
//
// class MerchantApp extends StatefulWidget {
//   const MerchantApp({super.key});
//
//   @override
//   State<MerchantApp> createState() => MerchantScreen();
// }
//
// class MerchantScreen extends State<MerchantApp> {
//   String salt = "58a63b64-574d-417a-9214-066bee1e4caa";
//   String callback = "flutterDemoApp";
//
//   Map<String, String> pgHeaders = {"Content-Type": "application/json"};
//   List<String> apiList = <String>['Container', 'PG'];
//   List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];
//   String apiEndPoint = "/pg/v1/pay";
//   bool enableLogs = true;
//   Object? result;
//   String dropdownValue = 'PG';
//   String environmentValue = 'UAT_SIM';
//   String appId = "test";
//   String merchantId = "ATMOSTUAT";
//   String packageName = "com.phonepe.app";
//
//
//   Map<String, dynamic> data={
//     "merchantId": "ATMOSTUAT",
//     "merchantTransactionId": "transaction_123",
//     "merchantUserId": "90223250",
//     "amount": "1000",
//     "mobileNumber": "9999999999",
//     "callbackUrl": "https://webhook.site/callback-url",
//     "paymentInstrument": {
//       "type": "UPI_INTENT",
//       "targetApp": "com.phonepe.app"
//     },
//     "deviceContext": {
//       "deviceOS": "ANDROID"
//     }
//   };
//   void startTransaction() {
//     dropdownValue == 'Container'
//         ? startContainerTransaction()
//         : startPGTransaction();
//   }
//
//   void initPhonePeSdk() {
//
//     PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
//         .then((isInitialized) => {
//       setState(() {
//         result = 'PhonePe SDK Initialized - $isInitialized';
//         index=1;
//         setData();
//       })
//     })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }
//
//
//
//   String checksum="";
//   String payloadBase64="";
//   setData()async{
//     try {
//       // Initialize PhonePe
//
//
//       // Create JSON data
//       Map<String, dynamic> data = {
//         "merchantTransactionId": "MERCHANT_TID",
//         "merchantId": merchantId,
//         "amount": 200,
//         "mobileNumber": "7908834635",
//         "callbackUrl": "https://webhook.site/callback-url",
//         "paymentInstrument": {
//           "type": "UPI_INTENT",
//           "targetApp": "com.phonepe.simulator",
//         },
//         "deviceContext": {
//           "deviceOS": "ANDROID",
//         },
//       };
//
//
//       String jsonData = jsonEncode(data);
//
//       // Encode the data to Base64
//         payloadBase64 = base64Encode(utf8.encode(jsonData));
//
//       // Calculate the checksum
//         checksum = sha256.convert(utf8.encode(payloadBase64 + apiEndPoint + salt)).toString() + "###1";
//
//       print("payloadBase64: $payloadBase64");
//       print("checksum: $checksum");
//
//       // Create a request
//
//
//       // Call PhonePe SDK
//
//
//     } catch (exception) {
//       print(exception);
//     }
//   }
//
//   void isPhonePeInstalled() {
//     PhonePePaymentSdk.isPhonePeInstalled()
//         .then((isPhonePeInstalled) => {
//       setState(() {
//         result = 'PhonePe Installed - $isPhonePeInstalled';
//       })
//     })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }
//
//   void isGpayInstalled() {
//     PhonePePaymentSdk.isGPayAppInstalled()
//         .then((isGpayInstalled) => {
//       setState(() {
//         result = 'GPay Installed - $isGpayInstalled';
//       })
//     })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }
//
//   void isPaytmInstalled() {
//     PhonePePaymentSdk.isPaytmAppInstalled()
//         .then((isPaytmInstalled) => {
//       setState(() {
//         result = 'Paytm Installed - $isPaytmInstalled';
//       })
//     })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }
//
//   void getPackageSignatureForAndroid() {
//     if (Platform.isAndroid) {
//       PhonePePaymentSdk.getPackageSignatureForAndroid()
//           .then((packageSignature) => {
//         setState(() {
//           result = 'getPackageSignatureForAndroid - $packageSignature';
//         })
//       })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     }
//   }
//
//   void getInstalledUpiAppsForAndroid() {
//     if (Platform.isAndroid) {
//       PhonePePaymentSdk.getInstalledUpiAppsForAndroid()
//           .then((apps) => {
//         setState(() {
//           if (apps != null) {
//             Iterable l = json.decode(apps);
//             List<UPIApp> upiApps = List<UPIApp>.from(
//                 l.map((model) => UPIApp.fromJson(model)));
//             String appString = '';
//             for (var element in upiApps) {
//               appString +=
//               "${element.applicationName} ${element.version} ${element.packageName}";
//             }
//             result = 'Installed Upi Apps - $appString';
//           } else {
//             result = 'Installed Upi Apps - 0';
//           }
//         })
//       })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     }
//   }
//
//   void startPGTransaction() async {
//
//
//     // Calculate the SHA-256 checksum
//
//
//     try {
//       PhonePePaymentSdk.startPGTransaction(
//           payloadBase64, callback, checksum, pgHeaders, apiEndPoint, packageName)
//           .then((response) => {
//         setState(() {
//           if (response != null) {
//             String status = response['status'].toString();
//             String error = response['error'].toString();
//             if (status == 'SUCCESS') {
//               result = "Flow Completed - Status: Success!";
//             } else {
//               result =
//               "Flow Completed - Status: $status and Error: $error";
//             }
//           } else {
//             result = "Flow Incomplete";
//           }
//         })
//       })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     } catch (error) {
//       handleError(error);
//     }
//   }
//
//   void handleError(error) {
//     setState(() {
//       if (error is Exception) {
//         result = error.toString();
//       } else {
//         result = {"error": error};
//       }
//     });
//   }
//
//   void startContainerTransaction() async {
//     try {
//         String xVerify = '${sha256.convert(utf8.encode("/pg/v1/status/$merchantId/transaction_123$salt")).toString()}###1';
//         Map<String, String> headers = {
//         "Content-Type": "application/json",
//         "X-VERIFY": "$xVerify",
//         "X-MERCHANT-ID": merchantId,
//       };
//       PhonePePaymentSdk.startContainerTransaction(
//           payloadBase64, callback, checksum, headers, apiEndPoint)
//           .then((response) => {
//         setState(() {
//           if (response != null) {
//             String status = response['status'].toString();
//             String error = response['error'].toString();
//             if (status == 'SUCCESS') {
//               result = "Flow Completed - Status: Success!";
//             } else {
//               result =
//               "Flow Completed - Status: $status and Error: $error";
//             }
//           } else {
//             result = "Flow Incomplete";
//           }
//         })
//       })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     } catch (error) {
//       result = {"error": error};
//     }
//   }
// int index=0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Flutter Merchant Demo App'),
//           ),
//           body: Column(
//     children: [
//       Text("data"),
//       ElevatedButton(onPressed:index==0? initPhonePeSdk:(){}, child: Text("${index==0?"Init":"Initialized"}")),
//       ElevatedButton(onPressed: startContainerTransaction, child: Text("Start PG transaction")),
//       Text("$result")
//
//     ],
//     ),
//     ));
//   }
// }class UPIApp {
//   final String? packageName;
//   final String? applicationName;
//   final String? version;
//
//   UPIApp(this.packageName, this.applicationName, this.version);
//
//   factory UPIApp.fromJson(Map<String, dynamic> parsedJson) {
//     return UPIApp(parsedJson['packageName'], parsedJson['applicationName'],
//         parsedJson['version'].toString());
//   }
// }



import 'dart:convert';
import 'dart:developer' as d;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final apiEndPoint = "/pg/v1/pay";



  String salt = "43ef5153-86c9-4c37-b0b6-8ed3af0b4aca";
  // String salt ="58a63b64-574d-417a-9214-066bee1e4caa";
  String callback = "flutterDemoApp";

  Map<String, String> pgHeaders = {"Content-Type": "application/json"};
  List<String> apiList = <String>['Container', 'PG'];
  List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];

  bool enableLogs = true;
  Object? result;
  // String dropdownValue = 'PG';
  String environmentValue = 'PRODUCTION';
  String appId = "d86587c3def64346afb9a260fac5dbd6";
  String merchantId = "M184GKQWC36Y";
  // String environmentValue = 'UAT';
  // String appId = "d86587c3def64346afb9a260fac5dbd6";
  // String merchantId = "ATMOSTUAT";
  @override
  void initState() {
    super.initState();
  PhonePePaymentSdk.init(environmentValue, appId, merchantId, true);// Ini;tialize the PhonePe SDK
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhonePe Payment Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: initiatePayment,
              child: Text("Initiate Payment"),
            ),
          ],
        ),
      ),
    );
  }
  String generateRandom10DigitNumber() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 10; i++) {
      number += random.nextInt(10).toString();
    }
    return number;
  }
  void initiatePayment() async {
    // Define your payment data
    final data = {
      "merchantTransactionId":DateTime.now().millisecondsSinceEpoch.toString(),
      "merchantId": merchantId,
      "amount": "200",
      "mobileNumber": "7908834635",
      "callbackUrl": "https://webhook.site/callback-url",
    "paymentInstrument": {
           "type": "UPI_INTENT",
           "targetApp": "com.phonepe.app",
     },
    "deviceContext": jsonEncode({"deviceOS": "ANDROID"}),
    };

    // Convert payment data to JSON and calculate the checksum


    // Create the PaymentRequest object
    // String xVerify = '${sha256.convert(utf8.encode("/pg/v1/status/$merchantId/transaction_123$salt")).toString()}###1';

      String jsonData = jsonEncode(data);

      // Encode the data to Base64
    String    payloadBase64 = base64Encode(utf8.encode(jsonData));

      // Calculate the checksum
  String      checksum = sha256.convert(utf8.encode(payloadBase64 + apiEndPoint + salt)).toString() + "###1";
    Map<String, String> headers = {
    "Content-Type": "application/json",
    "X-VERIFY":checksum,
    "X-MERCHANT-ID": merchantId,
    };
    // Initiate the payment
   d. log("CheckSum: $checksum");    d.log("Payload: $payloadBase64");
    final result =await PhonePePaymentSdk.startPGTransaction(payloadBase64, callback, checksum, headers, apiEndPoint,"com.phonepe.app");
     print(result);
  }


}
