//
//  AccountViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 17/07/25.
//
import Foundation

class AccountViewModel {
    struct AccountDetail {
        let title: String
    }
    
    enum AccountTabel {
        case userName
        case watchlist([AccountDetail])
        case recommondations([AccountDetail])
        case createdList([AccountDetail])
        case signout
    }

    var sections = [
        AccountTabel.userName,
        AccountTabel.watchlist([
            AccountDetail(title: "Favorites"),
            AccountDetail(title: "WatchList")
        ]),
        AccountTabel.recommondations([
            AccountDetail(title: "Recommendations")

        ]),
        AccountTabel.createdList([
            AccountDetail(title: "Created Lists")
        ]),
        AccountTabel.signout
    ]

    func numberOfRows(section: Int) -> Int{
        let item = sections[section]
           switch item {
           case .userName:
               return 1
           case .watchlist(let list):
               return list.count
           case .recommondations(let list):
               return list.count
           case .createdList(let list):
               return list.count
           case .signout:
               return 1
           }
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func headerTitle(section: Int) -> String {
        let section = sections[section]
        switch section {
        case .userName: return " "
        case .watchlist: return " "
        case .recommondations: return " "
        case .createdList: return " "
        case .signout: return " "
        }
    }
}
