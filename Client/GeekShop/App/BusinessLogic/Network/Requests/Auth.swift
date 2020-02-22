//
//  Auth.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol AuthRequestFactory {
    func login(with data: UserData, completion: @escaping (DataResponse<AuthResponse>) -> Void)
    func logout(with userId: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void)
    func register(with data: UserData, completion: @escaping (DataResponse<AuthResponse>) -> Void)
    func changeUserData(with data: UserData, completion: @escaping (DataResponse<AuthResponse>) -> Void)
}

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl = URL(string: "http://127.0.0.1:8181/")!

    init(
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    
    func login(with data: UserData, completion: @escaping (DataResponse<AuthResponse>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, data: data)
        self.request(request: requestModel, completionHandler: completion)
    }

    func logout(with userId: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completion)
    }

    func register(with data: UserData, completion: @escaping (DataResponse<AuthResponse>) -> Void) {
        let requestModel = Register(baseUrl: baseUrl, data: data)
        self.request(request: requestModel, completionHandler: completion)
    }

    func changeUserData(with data: UserData, completion: @escaping (DataResponse<AuthResponse>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, data: data)
        self.request(request: requestModel, completionHandler: completion)
    }
    
}

extension Auth {
    
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "auth.login"

        let data: UserData
        var parameters: Parameters? {
            return [
                "username": data.username,
                "password": data.password
            ]
        }
    }

    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "auth.register"

        let data: UserData

        var parameters: Parameters? {
            return [
                "username": data.username,
                "password": data.password,
                "name": data.name as Any,
                "surname": data.surname as Any,
                "email": data.email as Any,
                "gender": data.gender as Any,
                "credit_card": data.creditCard as Any,
                "bio": data.bio as Any
            ]
        }
    }

    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "user.changeData"

        let data: UserData

        var parameters: Parameters? {
            return [
                "user_id": data.id as Any,
                "username": data.username,
                "password": data.password,
                "name": data.name as Any,
                "surname": data.surname as Any,
                "email": data.email as Any,
                "gender": data.gender as Any,
                "credit_card": data.creditCard as Any,
                "bio": data.bio as Any
            ]
        }
    }

    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "auth.logout"

        let userId: Int

        var parameters: Parameters? {
            return [
                "user_id": userId
            ]
        }
    }
    
}
