//
//  IAButton.swift
//  concentration
//
//  Created by 1 on 30.01.2023.
//

import UIKit

struct UIConsts {
    static let bntBg: UIColor = .link.withAlphaComponent(0.2)
}

class IAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        self.backgroundColor = UIConsts.bntBg
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.titleLabel?.font = .systemFont(ofSize: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
