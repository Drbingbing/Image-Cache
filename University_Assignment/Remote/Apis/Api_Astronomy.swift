//
//  Api_Astronomy.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

extension Api.functions.Astronomy {
    
    static func allAstronomy() -> (FunctionDescription, DeserializeFunctionResponse<[Astronomy]>) {
        return (
            FunctionDescription(path: "cmmobile/NasaDataSet/main/apod.json", parameters: [:]),
            DeserializeFunctionResponse { data in
                guard let data else { return [] }
                let decoder = JSONDecoder()
                let result = try? decoder.decode([Astronomy].self, from: data)
                return result ?? []
            }
        )
    }
}
