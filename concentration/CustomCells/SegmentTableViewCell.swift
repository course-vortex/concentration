//
//  SegmentTableViewCell.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 18.02.2023.
//

import UIKit

class SegmentTableViewCell: UITableViewCell {
    
    static let identifier = "SegmentTableViewCell"
    
    var segmentHandler: ((Int) -> Void)?
    
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
    
    var items: [String]?
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
       
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(segmentedControl)
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
        
        segmentedControl.sizeToFit()
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //            segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //            segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    @objc private func segmentedControlValueChanged() {
        segmentHandler?(segmentedControl.selectedSegmentIndex)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        segmentedControl.removeAllSegments()
    }
    
    public func configure(with model: SettingsSegmentOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        items = model.segments
        
        guard (items != nil) else { return }
        for (index, item) in items!.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 0

    }
}


