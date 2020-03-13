//
//  BaseRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class BaseRouter: NSObject {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ controller: UIViewController, sender: Any?) {
        self.controller.show(controller, sender: sender)
    }
    
    func present(_ controller: UIViewController, animated: Bool) {
        self.controller.present(controller, animated: animated)
    }
    
    func dismiss(aminated: Bool, completion: (() -> Void)?) {
        self.controller.dismiss(animated: aminated, completion: completion)
    }
    
    func push(_ controller: UIViewController, animated: Bool) {
        self.controller.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        self.controller.navigationController?.popViewController(animated: animated)
    }
    
}
