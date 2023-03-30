//
//  CTAlertable.swift
//  CarTrack
//
//  Created by Shubham Raj on 30/03/23.
//

import Foundation

import UIKit

public protocol CTAlertable {}
public extension CTAlertable where Self: UIViewController {
    
    func showAlert(title: String = "",
                   message: String,
                   preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
