//
//  ViewController.swift
//  bio-example
//
//  Created by Richa Singh on 20/12/21.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(frame: CGRect(x:0, y: 0, width: 200, height:50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    print("Error ", error)
                    print("Success ", success)
                  guard success, error == nil else {
                    return
                }
                    let vc = UIViewController()
                    vc.title = "Welcome"
                    vc.view.backgroundColor = .systemBlue
                    self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            }
        }
        else {
            print(error)
            let alert = UIAlertController(title: "Unavailable", message: "You cannot use the app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
}

