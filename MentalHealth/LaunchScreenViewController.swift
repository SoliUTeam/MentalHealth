//
//  LaunchScreenViewController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/3/24.
//

import Foundation
import Lottie
import UIKit

class LaunchScreenViewController: UIViewController {
    
    var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        animationView = .init(name: "LaunchAnimation")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 0.7
        view.addSubview(animationView!)
        animationView!.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let homeViewController = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {
                        return
                    }
            self.hidesBottomBarWhenPushed  = false
            //self.tabBarController?.navigationController?.pushViewController(homeViewController, animated: false)
            self.navigationController?.pushViewController(homeViewController, animated: false)
            
        }
    }
}
