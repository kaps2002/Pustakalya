//
//  CommonViewModel.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import Foundation
import Alamofire
import UIKit

@Observable
class CommonViewModel {
    var isAlert = false
    
    func checkInternet(completion: @escaping (Bool) -> Void) {
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening(onQueue: .main) { status in
            let isInternetConnected = status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular)
            completion(isInternetConnected)
        }
    }
    
    func settingsOpener() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
