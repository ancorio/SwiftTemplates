//
//  NetworkFetcher.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

typealias NetworkError = Error

enum MappingFetcherError<RequestErrorType, MapperErrorType: Error>: Error {
    case request(RequestErrorType)
    case mapper(MapperErrorType)
}

protocol NetworkFether: Fetcher where RequestType == NetworkRequest, ResultType == NetworkResponse, ErrorType == NetworkError {

}

typealias NetworkFetcherResult = FetcherResult<NetworkResponse, Error>

protocol JsonFether: Fetcher where ResultType == JsonEntity {

}

protocol MappingFetcher: Fetcher where FetcherType.ResultType == MapperType.FromType, RequestType == FetcherType.RequestType, ResultType == MapperType.ToType, ErrorType == MappingFetcherError<FetcherType.ErrorType, MapperType.MapperErrorType> {
    associatedtype FetcherType: Fetcher
    associatedtype MapperType: Mapper

}

struct MappingFetcherImpl<FT: Fetcher, MT: Mapper>: MappingFetcher where FT.ResultType == MT.FromType {
    
    typealias FetcherType = FT
    typealias MapperType = MT
    typealias ResultType = MT.ToType
    typealias ErrorType = MappingFetcherError<FT.ErrorType, MT.MapperErrorType>

    let fetcher: FT
    let mapper: MT
    
    
    typealias RequestType = FT.RequestType
    
    
    func fetch(request: RequestType, result resultBlock: @escaping (Result<ResultType, ErrorType>) -> ()) {
        fetcher.fetch(request: request) { (result) in
            switch result {
            case .success(let from):
                switch self.mapper.map(from) {
                case .success(let rst):
                    resultBlock(.success(rst))
                case .error(let error):
                    resultBlock(.error(.mapper(error)))
                }
            case .error(let error):
                resultBlock(.error(.request(error)))
            }
        }
    }
    
}


extension Fetcher {
    #warning("Can be declared without mentioning MappingFetcherImpl???")
    func wrap<WithMapper: Mapper>(mapper: WithMapper) -> MappingFetcherImpl<Self, WithMapper> {
        return MappingFetcherImpl<Self, WithMapper>(fetcher: self, mapper: mapper)
    }
    
}

