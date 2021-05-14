//
//  Alert.swift
//  Fooddy
//
//  Created by Mano on 14/05/21.
//

import Foundation
import UIKit
import SwiftMessages

extension  UIViewController {
    
    func showAlert(title: String,message: String,theme: Theme){

           let messageView: MessageView
           messageView = MessageView.viewFromNib(layout: .cardView)
           messageView.titleLabel?.isHidden = true
           messageView.button?.isHidden = true
           messageView.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "    Ok    ", buttonTapHandler: { _ in SwiftMessages.hide() })
           messageView.configureTheme(theme)
           messageView.backgroundView.backgroundColor = #colorLiteral(red: 0.9860013127, green: 0.4296327233, blue: 0.2332445383, alpha: 1)
           messageView.configureDropShadow()

           var config = SwiftMessages.defaultConfig
           config.presentationStyle = .bottom
           config.duration = .seconds(seconds: 2)
           config.interactiveHide = true
           config.shouldAutorotate = false
           config.dimMode = .color(color: .clear, interactive: true)
           SwiftMessages.show(config: config, view: messageView)

    }
}

