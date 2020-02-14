//
//  Auth.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol AuthRequestFactory {
    func login(username: String, password: String, completion: @escaping (DataResponse<LoginResponse>) -> ())
    func logout(id: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void)
    func register(username: String, password: String, name: String, surname: String, email: String, gender: String, creditCard: String, bio: String, completion: @escaping (DataResponse<RegisterResponse>) -> ())
    func changeUserData(id: Int, username: String, password: String, name: String, surname: String, email: String, gender: String, creditCard: String, bio: String, completion: @escaping (DataResponse<ResultResponse>) -> ())
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
    
    func login(username: String, password: String, completion: @escaping (DataResponse<LoginResponse>) -> ()) {
        let requestModel = Login(baseUrl: baseUrl, login: username, password: password)
        self.request(request: requestModel, completionHandler: completion)
    }

    func logout(id: Int, completion: @escaping (DataResponse<ResultResponse>) -> ()) {
        let requestModel = Logout(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completion)
    }

    func register(username: String, password: String, name: String, surname: String, email: String, gender: String, creditCard: String, bio: String, completion: @escaping (DataResponse<RegisterResponse>) -> Void) {
        let requestModel = Register(baseUrl: baseUrl, username: username, password: password, name: name, surname: surname, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completion)
    }

    func changeUserData(id: Int, username: String, password: String, name: String, surname: String, email: String, gender: String, creditCard: String, bio: String, completion: @escaping (DataResponse<ResultResponse>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, id: id, username: username, password: password, name: name, surname: surname, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completion)
    }
    
}

extension Auth {
    
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "auth.login"

        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }

    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "auth.register"

        let username: String
        let password: String
        let name: String
        let surname: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String

        var parameters: Parameters? {
            return [
                "username": username,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }

    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "user.changeData"

        let id: Int
        let username: String
        let password: String
        let name: String
        let surname: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String

        var parameters: Parameters? {
            return [
                "user_id": id,
                "username": username,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }

    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "auth.logout"

        let id: Int

        var parameters: Parameters? {
            return [
                "user_id": id
            ]
        }
    }
    
}
