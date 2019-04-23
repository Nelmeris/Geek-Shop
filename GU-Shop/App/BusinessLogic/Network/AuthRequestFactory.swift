//
//  AuthRequestFactory.swift
//  GU-Shop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    func registr(userId: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<RegistrResult>) -> Void)
}
