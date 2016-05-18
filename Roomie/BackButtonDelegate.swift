//
//  BackButtonDelegate.swift
//  Roomie
//
//  Created by Gabe Ratcliff on 5/17/16.
//  Copyright © 2016 Alec Barlow. All rights reserved.
//

import UIKit
protocol BackButtonDelegate: class{
    func backButtonPressedFrom(controller:UITableViewController)
    func back2ButtonPressedFrom(controller:UIViewController)
}
