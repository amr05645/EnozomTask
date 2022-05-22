//
//  ViewController.swift
//  IOSTaskForENozom
//
//  Created by Amr Hassan on 22/05/2022.
//

import UIKit
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testMd5()
    }
    
    func MD5(string: String) -> Data {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            return digestData
        }
    
    func testMd5() {
        
        if let url = URL(string: "https://www.dropbox.com/s/78eky0zbzs0qedk/testcase.csv?dl=0") {
            
            do {
                let contents = try String(contentsOf: url)
                //Test:
                let md5Data = MD5(string:contents)

                let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
                print("md5Hex: \(md5Hex)")

                let md5Base64 = md5Data.base64EncodedString()
                print("md5Base64: \(md5Base64)")
                
//                let md5String = contents.withCString { data in
//                    print("data is", data.self)
//                }
////                print("md5String:", md5String)

                print("contents is: ",contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
            }


}

