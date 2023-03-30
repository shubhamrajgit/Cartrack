//
//  CTStoryboardInstantiable.swift
//  CarTrack
//
//  Created by Shubham Raj on 30/03/23.
//

import UIKit

public protocol CTStoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

//MARK: - CTStoryboardInstantiable
//We should always keep the storyboard identifier name as same as the associated file name.s
public extension CTStoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return "Main"
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        if #available(iOS 13.0, *) {
            guard let vc = storyboard.instantiateViewController(identifier: String(describing: self)) as? Self else {
                
                fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
            }
            return vc
        } else {
            // Fallback on earlier versions
            guard let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
                fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
            }
            return vc
        }
        
    }
}
