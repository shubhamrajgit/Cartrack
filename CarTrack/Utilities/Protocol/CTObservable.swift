//
//  CTObservable.swift
//  CarTrack
//
//  Created by Shubham Raj on 30/03/23.
//

import Foundation

enum ObserverTypeEnum {
      case dataLoading
      case dataLoaded
      case dataFailed
      case noNetwork
}

typealias ObserverBlock = ((_ observerType: ObserverTypeEnum)->Void)?

protocol CTObservableProtocol {
    var observerBlock: ObserverBlock { get }
}

class CTObservableType: NSObject, CTObservableProtocol {
    var observerBlock: ObserverBlock = nil
    
    override init() {
        super.init()
    }
}
