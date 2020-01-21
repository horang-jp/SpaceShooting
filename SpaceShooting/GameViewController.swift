//
//  GameViewController.swift
//  SpaceShooting
//
//  Created by 김호중 on 2019/09/29.
//  Copyright © 2019 hojung. All rights reserved.
//

import SpriteKit
import GoogleMobileAds

class GameViewController: UIViewController {
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.frame.origin = CGPoint(x: 0, y: view.frame.size.height - adBannerView.frame.height)
        adBannerView.frame.size = CGSize(width: view.frame.size.width, height: adBannerView.frame.size.height)
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let admobRequest = GADRequest()
        GADMobileAds.sharedInstance().requestConfiguration.tag(forChildDirectedTreatment: true)
//        admobRequest.testDevices = [(kGADSimulatorID as! String), "", "" ]
        adBannerView.load(admobRequest)
        
        if let view = self.view as! SKView? {
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Success to receive ads")
        self.view.addSubview(adBannerView)
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
}
