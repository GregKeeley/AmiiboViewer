//
//  AmiiboAPI.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/3/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

struct amiiboAPI {
    static func getAllAmiibos(completion: @escaping (Result<[AmiiboElement], AppError>) -> ()) {
        let amiiboEndpoint = "https://www.amiiboapi.com/api/amiibo/"
        guard let url = URL(string: amiiboEndpoint) else {
            completion(.failure(.badURL(amiiboEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(AmiiboInfo.self, from: data)
                    let sortedAmiibos = searchResults.amiibo
                    completion(.success(sortedAmiibos))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
}
