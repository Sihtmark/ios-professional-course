import UIKit

/*
   _                      _      ___ _         _ _
  /_\  __ __ ___ _  _ _ _| |_   / __| |_  __ _| | |___ _ _  __ _ ___
 / _ \/ _/ _/ _ \ || | ' \  _| | (__| ' \/ _` | | / -_) ' \/ _` / -_)
/_/ \_\__\__\___/\_,_|_||_\__|  \___|_||_\__,_|_|_\___|_||_\__, \___|
                                                         |___/
 
 See if you can fill in the blanks for the Account model below and parse
 the included JSON.
 
 - Use type `Decimal` for amount.
 - Use type `String` and `Date` for the others.
 
 But give it a go!
 
 */

let json = """
 [
   {
     "id": "1",
     "type": "Banking",
     "name": "Basic Savings",
     "amount": 929466.23,
     "createdDateTime" : "2010-06-21T15:29:32Z"
   },
   {
     "id": "2",
     "type": "Banking",
     "name": "No-Fee All-In Chequing",
     "amount": 17562.44,
     "createdDateTime" : "2011-06-21T15:29:32Z"
   },
  ]
"""

struct AccountModel: Codable {
    // 🕹 Game on here
    let id: String
    let type: String
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}

let jsonData = json.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let result = try! decoder.decode([AccountModel].self, from: jsonData)
