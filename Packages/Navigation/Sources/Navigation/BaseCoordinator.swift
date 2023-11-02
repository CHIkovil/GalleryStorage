//
//  BaseCoordinator.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation


open class BaseCoordinator {
    
    var childCoordinators: [Coordinatable]
    
    // MARK: - Init
    
    public init(childCoordinators: [Coordinatable] = []) {
        self.childCoordinators = childCoordinators
    }
    
    // MARK: - Coordinator

    open func start() {}
    
    // MARK: - Actions
        
    public func add(coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        
        childCoordinators.append(coordinator)
    }
    
    public func remove(coordinator: Coordinatable?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else { return }
        
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.remove(coordinator: $0) })
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
