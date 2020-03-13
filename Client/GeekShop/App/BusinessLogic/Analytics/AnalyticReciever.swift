//
//  Analytic.swift
//  GeekShop
//
//  Created by Artem Kufaev on 22.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import FirebaseAnalytics

final class AnalyticReciever {
    
    func sendToFirebase(_ event: AnalyticEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
    
}
