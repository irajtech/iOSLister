//
//  LoadingIndicator.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import UIKit

public class LoadingIndicator: NSObject {
    
    public static let sharedInstance = LoadingIndicator()
    public var activityIndicator = UIActivityIndicatorView()
    public var textLabel = UILabel()
    public var loadingView: UIView = UIView()
    
    //MARK: - Private Methods -
    private func setupLoader() {
        removeLoader()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = UIColor.blue
    }
    
    //MARK: - Public Methods -
    open func showLoader(ignoreTouch: Bool = false) {
        setupLoader()
        
        let currentWindow: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let holdingView = currentWindow.rootViewController!.view!
        
        DispatchQueue.main.async {
            self.activityIndicator.center = holdingView.center
            self.activityIndicator.startAnimating()
            holdingView.addSubview(self.activityIndicator)
            if ignoreTouch {
                self.loadingView.isUserInteractionEnabled = false
            }
        }
    }
    
    open func showLoaderonView(view: UIView, message: String = "", bgColor: UIColor = UIColor.clear, messageColor: UIColor = UIColor.black, ignoreTouch: Bool = false) {
        setupLoader()
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                return
            }
            self.activityIndicator.startAnimating()
            
            //Text Label
            self.textLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            self.textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            self.textLabel.text = message
            self.textLabel.textColor = messageColor
            self.textLabel.textAlignment = .center
            
            let stackView = UIStackView()
            stackView.frame.size = CGSize(width: 100, height: 50)
            stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.distribution = UIStackView.Distribution.equalSpacing
            stackView.alignment = UIStackView.Alignment.center
            stackView.spacing = 10
            stackView.addArrangedSubview(self.activityIndicator)
            message.count > 1 ? stackView.addArrangedSubview(self.textLabel) : stackView.removeArrangedSubview(self.textLabel)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            self.loadingView.frame.size = CGSize(width: stackView.frame.size.width, height: 80)
            self.loadingView.addSubview(stackView)
            self.loadingView.center = view.center
            self.loadingView.backgroundColor = bgColor
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            stackView.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor).isActive = true
            stackView.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor).isActive = true
            view.addSubview(self.loadingView)
            
            if ignoreTouch {
                self.loadingView.isUserInteractionEnabled = false
            }
        }
    }
    
    open func removeLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.loadingView.removeFromSuperview()
            self.loadingView.isUserInteractionEnabled = true
            
        }
    }
    
    @objc func orientationChanged() {
        let loader = LoadingIndicator.sharedInstance
        let height: CGFloat = UIScreen.main.bounds.size.height
        let width: CGFloat = UIScreen.main.bounds.size.width
        let center: CGPoint = CGPoint(x: width / 2.0, y: height / 2.0 - CGFloat(0))
        loader.activityIndicator.center = center
    }
    
}

