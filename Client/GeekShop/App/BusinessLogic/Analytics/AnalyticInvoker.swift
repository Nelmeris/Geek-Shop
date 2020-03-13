//
//  AnalyticInvoker.swift
//  GeekShop
//
//  Created by Artem Kufaev on 22.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

internal final class AnalyticInvoker {
    
    // MARK: Singleton
    
    internal static let shared = AnalyticInvoker()
    
    // MARK: Private properties
    
    private let reciever = AnalyticReciever()
    
    private let batchSize = 1
    
    private var commands: [AnalyticCommand] = []
    
    // MARK: Internal
    
    internal func add(_ command: AnalyticCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    // MARK: Private
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else { return }
        self.commands.forEach { self.reciever.sendToFirebase($0.event) }
        self.commands = []
    }
}
