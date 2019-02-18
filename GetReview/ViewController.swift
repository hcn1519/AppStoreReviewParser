//
//  ViewController.swift
//  GetReview
//
//  Created by 홍창남 on 19/02/2019.
//  Copyright © 2019 홍창남. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let reviewParser = ReviewParser()

    override func viewDidLoad() {
        super.viewDidLoad()

        reviewParser.getReview(pageNo: 1, appID: 393499958) {
            print("completion!")
        }
    }


}

