//
//  MeterCell.swift
//  Coughee
//
//  Created by Melvin  Hernandez and Juan Cervantes on 5/1/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation
import UIKit
import GTProgressBar

class MeterCell: BasePostCell {
    
    static var fillColors: [UIColor] = [
        UIColor(red:0.18, green:0.80, blue:0.44, alpha: 0.8), // Green
        UIColor(red:0.99, green:0.59, blue:0.27, alpha: 0.8), // Orange
        UIColor(red:0.91, green:0.30, blue:0.24, alpha: 0.8) // Red
    ]
    
    static var borderColors: [UIColor] = [
        UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0), // Green
        UIColor(red:0.99, green:0.59, blue:0.27, alpha:1.0), // Orange
        UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0) // Red
    ]
    
    static var bgColors: [UIColor] = [
        UIColor(red:0.18, green:0.80, blue:0.44, alpha:0.2), // Green
        UIColor(red:0.99, green:0.59, blue:0.27, alpha:0.2), // Orange
        UIColor(red:0.91, green:0.30, blue:0.24, alpha:0.2) // Red
    ]
    
    static var message: [String] = [
        "Keep sipping yo'",
        "Getting a little jittery there?",
        "It must be finals week?"
    ]
    
    var mgs: Int?
    
    let meter : GTProgressBar = {
        let progressBar = GTProgressBar(frame: CGRect(x: 0, y: 0, width: 300, height: 15))
        progressBar.progress = 0.7
        progressBar.barBorderColor = borderColors[1]
        progressBar.barFillColor = fillColors[1]
        progressBar.barBackgroundColor = bgColors[1]
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.labelTextColor = fillColors[1]
        progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        progressBar.font = UIFont.boldSystemFont(ofSize: 18)
        progressBar.labelPosition = GTProgressBarLabelPosition.bottom
        progressBar.barMaxHeight = 20
        progressBar.direction = GTProgressBarDirection.clockwise
        progressBar.progressLabelInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "YOU HAVE CONSUMED"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mgLabel : UILabel = {
        let label = UILabel()
        label.text = "0mgs"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLabel : UILabel = {
        let label = UILabel()
        label.text = "TODAY"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textContainer : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let meterContainer : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    let messageContent: UILabel = {
        let label = UILabel()
        label.text = message[2]
        label.textAlignment = .center
        label.textColor = Colors.lightGray
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hr: UIView = {
        let hr = UIView()
        hr.backgroundColor = Colors.midPastelBlue
        hr.translatesAutoresizingMaskIntoConstraints = false
        return hr
    }()
    
    let postsTitle : UILabel = {
        let label = UILabel()
        label.text = "Your Posts"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .white
        
        self.addSubview(textContainer)
        textContainer.addSubview(messageLabel)
        if let milli = self.mgs {
            meter.progress = CGFloat(milli)/400
            mgLabel.text = "\(milli)mgs"
        }
        if meter.progress < 0.6 {
            meter.barBorderColor = MeterCell.borderColors[0]
            meter.barFillColor = MeterCell.fillColors[0]
            meter.barBackgroundColor = MeterCell.bgColors[0]
            meter.labelTextColor = MeterCell.fillColors[0]
            messageContent.text = MeterCell.message[0]
        } else if (meter.progress > 0.6) && (meter.progress < 0.9) {
            meter.barBorderColor = MeterCell.borderColors[1]
            meter.barFillColor = MeterCell.fillColors[1]
            meter.barBackgroundColor = MeterCell.bgColors[1]
            meter.labelTextColor = MeterCell.fillColors[1]
            messageContent.text = MeterCell.message[1]
        } else {
            meter.barBorderColor = MeterCell.borderColors[2]
            meter.barFillColor = MeterCell.fillColors[2]
            meter.barBackgroundColor = MeterCell.bgColors[2]
            meter.labelTextColor = MeterCell.fillColors[2]
            messageContent.text = MeterCell.message[2]
        }
        meter.animateTo(progress: meter.progress)
        textContainer.addSubview(mgLabel)
        textContainer.addSubview(dayLabel)
        
        let textCons = [
            textContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            textContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            textContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: textContainer.topAnchor),
            messageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 22),
            messageLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor),
            mgLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            mgLabel.heightAnchor.constraint(equalToConstant: 40),
            mgLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor),
            mgLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor),
            dayLabel.topAnchor.constraint(equalTo: mgLabel.bottomAnchor, constant: 20),
            dayLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 22),
            dayLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor)
        ]
        NSLayoutConstraint.activate(textCons)
        
        self.addSubview(meter)
        self.addSubview(messageContent)
        self.addSubview(hr)
        self.addSubview(postsTitle)
        let meterCons = [
            meter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            meter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),
            meter.topAnchor.constraint(equalTo: textContainer.bottomAnchor),
            meter.heightAnchor.constraint(lessThanOrEqualToConstant: 50)
        ]
        NSLayoutConstraint.activate(meterCons)
    
        let msgContentCons = [
            messageContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            messageContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            messageContent.topAnchor.constraint(equalTo: meter.bottomAnchor, constant: 8),
            messageContent.bottomAnchor.constraint(equalTo: hr.topAnchor)
        ]
        NSLayoutConstraint.activate(msgContentCons)
        
        let hrCons = [
            hr.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            hr.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hr.bottomAnchor.constraint(equalTo: postsTitle.topAnchor, constant: -30),
            hr.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(hrCons)
        
        let postsTitleCons = [
            postsTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            postsTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),
            postsTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            postsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(postsTitleCons)
    }
}
