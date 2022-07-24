//
//  Constants.swift
//  ContactApp
//
//  Created by Moetez Hechmi Groun on 24/07/22.
//

import Foundation
import UIKit


struct DB_TABLE {
    static let Person = "Person"
}

struct SEGUE {
    static let CONTACT_DETAIL = "detailSegue"
    static let ADD_PHONE = "addPhoneSegue"
}

struct TABLE_IDENTIFIER {
    static let PhoneCellID = "PhoneCellID"
    static let NoteCellID = "noteCellID"
}

struct IMAGE {
    static let DEFAULT_IMAGE = "https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png"
}

struct DEFAULT_DATA {
    static let DEFAULT_IMAGE = "https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png"
    
    static let MOCK_IMAGE1 = "https://cdn.pixabay.com/photo/2016/04/26/07/57/woman-1353825_960_720.png"
    static let MOCK_NAME1 = "Rihana"
    static let MOCK_NAME2 = "Drawn"
    static let MOCK_PHONE1 = ["+222222222","+44444444444"]
    
    static let MOCK_IMAGE2 = "https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_960_720.png"
    static let MOCK_SURNAME1 = "Adams"
    static let MOCK_SURNAME2 = "Rio"
    static let MOCK_PHONE2 = ["+222222222"]
    
}

struct ERR_MESSAGE {
    static let NAME = "Name must contains at least 3 caracter"
    static let SURNAME = "Surname must contains at least 3 caracter"
    static let PHOTO = "This is not a valid url"
    static let PHONE_NUMBER = "Not valid phone Number"
    static let EMPTY = ""
}



