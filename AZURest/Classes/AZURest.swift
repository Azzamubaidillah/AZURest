//
//  AZURest.swift
//  AZURest
//
//  Created by Azzam Ubaidillah on 10/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON

public class AZURest
{
    public static func runRequest(urlRequest : URLRequest, jsonValidation : ((JSON) -> (AZURestError?))? = nil, callback : @escaping (AZURestError?, JSON?) -> ()) -> DataRequest
    {
        var req = request(urlRequest).responseJSON { response in
            var json : JSON?
            var err : AZURestError?
            switch response.result {
            case .success(let value) :
                json = JSON(value)
            case .failure(let error) :
                if let nserror = error as? NSError
                {
                    if nserror.code == -1001
                    {
                        err = .timeout
                    } else if nserror.code == 401 {
                        err = .unauthorized
                    } else {
                        err = .serverFailure(code: nserror.code, message: nserror.localizedDescription)
                    }
                }
            }
            
            if let validator = jsonValidation, let jsonData = json, err == nil
            {
                if let error = validator(jsonData)
                {
                    err = error
                }
            }
            
            callback(err, json)
        }
        
        return req
    }
}
