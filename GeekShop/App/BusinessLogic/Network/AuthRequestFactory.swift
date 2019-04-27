//
//  AuthRequestFactory.swift
<<<<<<< HEAD:Geek-Shop/App/BusinessLogic/Network/AuthRequestFactory.swift
//  Geek-Shop
=======
//  GeekShop
>>>>>>> remotes/origin/feature/lesson-3:GeekShop/App/BusinessLogic/Network/AuthRequestFactory.swift
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    func register(userId: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<RegisterResult>) -> Void)
    func changeUserData(userId: Int, userName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void)
}
