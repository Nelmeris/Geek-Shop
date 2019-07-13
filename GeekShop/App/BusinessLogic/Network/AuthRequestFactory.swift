//
//  AuthRequestFactory.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResponse>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (DataResponse<ResultResponse>) -> Void)
    func register(userId: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<RegisterResponse>) -> Void)
    func changeUserData(userId: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<ResultResponse>) -> Void)
}
