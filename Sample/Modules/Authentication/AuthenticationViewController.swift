//
//  AuthenticationViewController.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 24.09.2020.
//

import Foundation
import UIKit

enum ProcessingStateType {
    case processing
    case error
    case content
}

protocol Processing where Self: UIViewController {
    var processingView: UIView! { get }
    var errorView: UIView! { get }
    var processingState: ProcessingStateType { set get }
}

extension Processing {
    var processingState: ProcessingStateType {
        set {
            setProcessing(state: newValue)
        }
        get {
            return state()
        }
    }

    private func setProcessing(state: ProcessingStateType) {
        switch state {
        case .processing:
            processingView.isHidden = false
            errorView.isHidden = true
        case .error:
            processingView.isHidden = true
            errorView.isHidden = false
        case .content:
            processingView.isHidden = true
            errorView.isHidden = true
        }
    }

    private func state() -> ProcessingStateType {
        if processingView.isHidden == false && errorView.isHidden == true {
            return .processing
        }

        if processingView.isHidden == true && errorView.isHidden == true {
            return .error
        }

        return .content
    }

}

class AuthenticationViewController: UIViewController {
    private(set) weak var spinner: UIActivityIndicatorView!
    private(set) weak var authErrorView: AuthenticationErrorView!

    var onAuthenticationRequest: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        self.spinner = spinner

        let errorView = AuthenticationErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.textLabel.text = NSLocalizedString("error", comment: "")
        errorView.repeatButton.addTarget(self, action: #selector(authenticationRequest), for: .touchUpInside)
        view.addSubview(errorView)
        self.authErrorView = errorView

        let spinnerContstraints = [spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                   spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                   errorView.topAnchor.constraint(equalTo: view.topAnchor),
                                   errorView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                   errorView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                   errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(spinnerContstraints)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        authenticationRequest()
    }


    // MARK: Handlers
    @objc func authenticationRequest() {
        onAuthenticationRequest?()
    }
}

extension AuthenticationViewController: Processing {
    var processingView: UIView! {
        return spinner
    }
    var errorView: UIView! {
        return authErrorView
    }
}
