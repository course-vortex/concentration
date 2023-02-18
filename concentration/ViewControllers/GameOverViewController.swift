//
//  GameOverViewController.swift
//  concentration
//
//  Created by Влад Андрушок on 07.02.2023.
//

import UIKit
import CoreGraphics

class GameOverViewController: UIViewController {
    
    var winLoseLabelText = "YOU WIN"
    var heightLable = CGFloat(50)
    var widthButton = CGFloat(150)
    var padding = CGFloat(88)
    var countBomb: Int?
    var countSeconds: Int?
    
    let gradientLayer = CAGradientLayer()
    
    let winLoseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundForWinLoseLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resultGameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundForResultGameLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonTryAgain: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22.0, weight: .regular)
        button.backgroundColor = .blue
        button.setTitle("try again", for: .normal)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()
    
    let buttonGoToMenu: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22.0, weight: .regular)
        button.backgroundColor = .blue
        button.setTitle("go to menu", for: .normal)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToMenu), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubview()
        setGradientLayer()
        setConstraint()
        setTextLabel()
    }
    
    func setGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
    }
    
    func addSubview() {
        view.layer.addSublayer(gradientLayer)
        backgroundForWinLoseLabelView.addSubview(winLoseLabel)
        backgroundForResultGameLabelView.addSubview(resultGameLabel)
        
        view.addSubview(backgroundForWinLoseLabelView)
        view.addSubview(backgroundForResultGameLabelView)
        
        view.addSubview(buttonGoToMenu)
        view.addSubview(buttonTryAgain)
    }
    
    func setConstraint() {
        
        backgroundForWinLoseLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundForWinLoseLabelView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -padding).isActive = true
        backgroundForWinLoseLabelView.widthAnchor.constraint(equalTo: winLoseLabel.widthAnchor, constant: 20).isActive = true
        backgroundForWinLoseLabelView.heightAnchor.constraint(equalTo: winLoseLabel.heightAnchor, constant: 20).isActive = true
        
        winLoseLabel.centerXAnchor.constraint(equalTo: backgroundForWinLoseLabelView.centerXAnchor).isActive = true
        winLoseLabel.centerYAnchor.constraint(equalTo: backgroundForWinLoseLabelView.centerYAnchor).isActive = true
        
        
        backgroundForResultGameLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundForResultGameLabelView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundForResultGameLabelView.widthAnchor.constraint(equalTo: resultGameLabel.widthAnchor, constant: 20).isActive = true
        backgroundForResultGameLabelView.heightAnchor.constraint(equalTo: resultGameLabel.heightAnchor, constant: 20).isActive = true
        
        resultGameLabel.centerXAnchor.constraint(equalTo: backgroundForResultGameLabelView.centerXAnchor).isActive = true
        resultGameLabel.centerYAnchor.constraint(equalTo: backgroundForResultGameLabelView.centerYAnchor).isActive = true
        
        
        buttonGoToMenu.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding).isActive = true
        buttonGoToMenu.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -padding).isActive = true
        buttonGoToMenu.heightAnchor.constraint(equalToConstant: heightLable).isActive = true
        buttonGoToMenu.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        
        buttonTryAgain.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding).isActive = true
        buttonTryAgain.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: padding).isActive = true
        buttonTryAgain.heightAnchor.constraint(equalToConstant: heightLable).isActive = true
        buttonTryAgain.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        
    }
    
    func setTextLabel() {
        winLoseLabel.text = winLoseLabelText
        if winLoseLabelText == "YOU WIN" {
            backgroundForWinLoseLabelView.backgroundColor = .systemGreen
        } else {
            backgroundForWinLoseLabelView.backgroundColor = .red
        }
        resultGameLabel.text = "you result: \(countBomb) bombs / \(countSeconds) seconds"
    }
    
    @objc func tryAgain() {
        print("tryAgain")
    }
    
    @objc func goToMenu() {
        print("goToMenu")
    }
    
}
