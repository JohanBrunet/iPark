//
//  FormValidator.swift
//  iPark
//
//  Created by Johan BRUNET on 24/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class FormValidator {
    
    static func formIsValid(_ tab:[UITextField]!) -> Bool {
        return (tab.count == filterValues(tab).count)
    }
    
    static func filterValues(_ inputs:[UITextField]) -> [UITextField]! {
        return inputs.filter{(item) in !(item.text?.isEmpty ?? true)}
    }
    
}
