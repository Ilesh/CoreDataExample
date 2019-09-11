//  Created by SAS
//  Copyright © 2017   All rights reserved.

import UIKit

//MARK: -  PUSH TO NEW VC
extension UIViewController {
    
    func pushToSinglVC<T: UIViewController>(vc: T, animated: Bool)  {
        if self.navigationController?.topViewController?.isKind(of: T.self) == false {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
}

//MARK: -  Share
extension UIViewController {
    func share(images:[UIImage]) {
        let activityViewController = UIActivityViewController(activityItems: images , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
