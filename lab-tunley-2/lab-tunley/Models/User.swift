//
//  User.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 11/29/22.
//

import Foundation

// TODO: Pt 1 - Import Parse Swift
import ParseSwift
import RealmSwift
// TODO: Pt 1 - Create Parse User model
// https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/3%20-%20User%20-%20Sign%20Up.xcplaygroundpage/Contents.swift#L16

class AppUser: Object {
    @Persisted(primaryKey: true) var _id: String?
    @Persisted var selectedNewsOutlets: List<String>
}
