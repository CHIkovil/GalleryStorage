//
//  BaseVC.swift
//  
//
//  Created by Sergei Gubin on 14.12.2022.
//

import UIKit

open class BaseVC: UIViewController {
    // MARK: - Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSubviews()
        setupAutolayout()
    }
    
    // MARK: - Setup
    
    open func setupSubviews() {
        assertionFailure("\(#function) needs to be overriden.")
    }
    
    open func setupAutolayout() {
        assertionFailure("\(#function) needs to be overriden.")
    }
    
    open func bind() {}
}
