//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Vinayak Sharma on 14/03/20.
//  Copyright © 2020 Vinayak Sharma. All rights reserved.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
