//
//  AlertService.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 04/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation
import PMAlertController

class AlertService {
    static func showLocationNotFoundAlert(viewController: UIViewController) {
        
        let alertVC = PMAlertController(title: "Город не найден", description: "Населенный пункт, который вы указали, не найден", image: UIImage(named: "sadCloud.png"), style: .alert)

        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                }))
        alertVC.alertTitle.font = Fonts.extraBoldOfSize18
        alertVC.alertDescription.font = Fonts.regularOfSize18
        
        viewController.present(alertVC, animated: true, completion: nil)
        
    }
}
