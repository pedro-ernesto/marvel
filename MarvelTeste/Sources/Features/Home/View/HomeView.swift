//
//  HomeView\.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/20/24.
//

import Foundation
import UIKit

class HomeView: UIView {
    // MARK - VARIABLES
    weak public var delegate: HomeViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK - SETUP
    
    private func setup() {
        //add subView bla bla
        setViewHierarchy()
        setConstraints()
    }
    
    // MARK - PRIVATE FUNCTIONS
    
    private func setViewHierarchy() {
        
    }
    
    private func setConstraints () {
        
    }
    
    // MARK - VIEW DELEGATE
}


