//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation

class RequestHandler {
        
    func networkResult<T: Decodable>(decodingType: T.Type, completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in 
                
                DispatchQueue.global(qos: .background).async(execute: { 
                    switch dataResult {
                    case .success(let data) : 
                        ParserHelper.parse(decodingType: decodingType, data: data, completion: completion)
                        break
                    case .failure(let msg) :
                        completion(.failure(msg))
                        break
                    }
                })
                
            }
    }
    
}
