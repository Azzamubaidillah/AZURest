//
//  AZURestError.swift
//  AZURest
//
//  Created by Azzam Ubaidillah on 10/08/23.
//

import Foundation

public enum AZURestError : Equatable
{
    case unknown
    case timeout
    case serverFailure(code : Int, message : String)
    case unauthorized
    
    func order() -> Int
    {
        switch self
        {
        case .unknown :
            return 1
        case .timeout :
            return 2
        case .serverFailure(let code, _) :
            return code
        case .unauthorized :
            return 3
        }
    }
}

public func ==(left: AZURestError, right: AZURestError) -> Bool
{
    return left.order() == right.order()
}
