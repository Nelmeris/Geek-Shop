//
//  HandlerFactory.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import PerfectHTTP

class HandlerFactory {
    public func handlerFor(request: HTTPRequest, response: HTTPResponse) -> AbstractHandler {
        switch request.path {
        case "/auth.login":
            return LoginHandler(request: request, response: response)
        case "/auth.register":
            return RegisterHandler(request: request, response: response)
        case "/user.changeData":
            return ChangeUserDataHundler(request: request, response: response)
        case "/auth.logout":
            return LogoutHandler(request: request, response: response)
        case "/catalog.get":
            return GetCatalogDataHandler(request: request, response: response)
        case "/catalog.getGood":
            return GetGoodByIdHandler(request: request, response: response)
        case "/review.add":
            return AddReviewHandler(request: request, response: response)
        case "/review.remove":
            return RemoveReviewHandler(request: request, response: response)
        case "/review.get":
            return GetReviewHandler(request: request, response: response)
        default:
            return ErrorHandler(request: request, response: response)
        }
    }
}
