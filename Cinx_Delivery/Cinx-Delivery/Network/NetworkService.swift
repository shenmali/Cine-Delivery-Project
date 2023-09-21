//
//  NetworkService.swift
//  Cinx-Delivery
//
//  Created by Ali on 18/08/2023.
//

import Foundation
import RxSwift

protocol APIService {
    func fetch(urlRequest: URLRequest) -> Observable<Data>
}

class NetworkService: APIService {
    
    func fetch(urlRequest: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            
            // Check for internet connectivity
            guard Connectability.isConnectedToNetwork() else {
                observer.onError(AppError.noInternet)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("Status Code: \(statusCode)")
                }
                
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let responseData = data else {
                    observer.onError(AppError.noData)
                    return
                }
                
                observer.onNext(responseData)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
