//
//  SliderTableViewCell.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 18.02.2023.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

        static let identifier = "SliderTableViewCell"
    
        var sliderHandler: ((Float) -> Void)?
        
        private let iconContainer: UIView = {
            let view = UIView()
            view.clipsToBounds = true
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            return view
        }()
        
        private let iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private let label: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            return label
        }()
        
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        return slider
    }()
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            contentView.addSubview(label)
            contentView.addSubview(iconContainer)
            contentView.addSubview(slider)
            iconContainer.addSubview(iconImageView)
            
            selectionStyle = .none
            contentView.clipsToBounds = true
            accessoryType = .none
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            let size: CGFloat = contentView.frame.size.height - 12
            
            iconContainer.translatesAutoresizingMaskIntoConstraints = false
            
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            iconContainer.widthAnchor.constraint(equalToConstant: size).isActive = true
            iconContainer.heightAnchor.constraint(equalToConstant: size).isActive = true

            let imageSize = size / 1.5
          
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor).isActive = true
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor).isActive = true
            iconImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            iconImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
                   
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16).isActive = true
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

            slider.sizeToFit()
            
            slider.translatesAutoresizingMaskIntoConstraints = false
            
            slider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            slider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            slider.widthAnchor.constraint(equalToConstant: 200).isActive = true // TODO: remake to trailling leading
            slider.heightAnchor.constraint(equalToConstant: 30).isActive = true

            
        }
    
    @objc func sliderValueChanged() {
        sliderHandler?(slider.value)
    }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            iconImageView.image = nil
            label.text = nil
            iconContainer.backgroundColor = nil
            slider.value = 0.5
        }
        
        public func configure(with model: SettingsSliderOption) {
            label.text = model.title
            iconImageView.image = model.icon
            iconContainer.backgroundColor = model.iconBackgroundColor
            slider.value = model.value
        }
    }


