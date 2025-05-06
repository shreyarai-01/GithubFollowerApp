//
//  Date+Ext.swift
//  GHFollowers

import Foundation

extension Date {
    
    func convertToMonethYearFormat() -> String {
        let dateFprmatter = DateFormatter()
        dateFprmatter.dateFormat = "MMMM yyyy"
        return dateFprmatter.string(from: self)
    }
    
   
    
}
