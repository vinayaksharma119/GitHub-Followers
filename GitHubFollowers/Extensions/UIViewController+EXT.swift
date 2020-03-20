//
//  UIViewController+EXT.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 26/02/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import UIKit

fileprivate var aView : UIView?

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC,animated: true)
        }
    }
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        
        Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false){(t) in
            self.removeSpinner()
            
        }
        
    }
    
    func removeSpinner(){
        DispatchQueue.main.async {
            aView?.removeFromSuperview()
            aView = nil
        }
     }
    
    func showEmptyStateView(with message: String,in view: UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
}

