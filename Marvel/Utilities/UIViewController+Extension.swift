//
//  UIViewController+Extension.swift
//  Marvel
//
//  Created by Mac on 23/06/2023.
//

import UIKit

extension UIViewController {
    private var loaderView: UIActivityIndicatorView? {
        return view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
    }
    
    func showLoader() {
        if let existingLoader = loaderView {
            existingLoader.startAnimating()
            return
        }
        
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loader.startAnimating()
    }
    
    func hideLoader() {
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
    }
    
    func showError(error:Error) {
        showErrorAlert(error: error.localizedDescription)
    }

    func showErrorAlert(error: String) {
        let alert = UIAlertController(title: AppString.Alert.error, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppString.Alert.ok, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
