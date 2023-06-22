//
//  Strings.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

struct AppString {
    
    struct Error {
        public static let emptyData = "There is no available data"
        public static let connection = "Connection is lost, please try again."
        public static let general = "Something went wrong."
        public static let authentication = "Please log in to continue"
        public static let noAvailableData = "no avaialable data"
    }
    
    struct Alert {
        public static let ok = "OK"
        public static let error = "Error"
    }
    
    struct ComicsScreen {
        public static let searchComics =  "Search for comics..."
    }
}

