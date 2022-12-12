//
//  RideType.swift
//  UberClone
//
//  Created by berat can beduk on 9.12.2022.
//

import Foundation
enum RideType : Int,CaseIterable,Identifiable {
    case uberX
    case blacks
    case uberXl
    
    var id: Int {return rawValue}
    
    var description : String {
        switch self {
        case .uberX : return "Uberx"
        case .blacks : return "UberBlack"
        case .uberXl : return "UberXl"
        }
        
    }
    
    var imageName : String {
        switch self {
        case .uberX: return "uber-x"
        case .blacks: return "uber-black"
        case .uberXl : return "uber-x"
        }
    }
    
    var baseFare : Double {
        switch self {
        case .uberX : return 5
        case.blacks : return 20
        case.uberXl : return 10
        }
    }
    
    func computePrice(for distanceInMeters : Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .uberX:  return distanceInMiles * 1.5 + baseFare
        case .blacks: return distanceInMiles * 2.0 + baseFare
        case .uberXl : return distanceInMiles * 1.75 + baseFare
        }
    }
}
