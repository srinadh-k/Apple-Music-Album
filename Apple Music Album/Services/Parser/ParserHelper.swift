//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import Foundation

final class ParserHelper {
    
    static func parse<T: Decodable>(decodingType: T.Type, data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
            let result = try JSONDecoder().decode(decodingType, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.parser(string: Constants.Messages.kSomethingWentWrong)))
        }
    }
}
