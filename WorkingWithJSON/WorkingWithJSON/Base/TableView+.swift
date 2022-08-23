//
//  TableView+.swift
//  Tutor
//
//  Created by Tuyen on 2/21/18.
//  Copyright © 2018 Tuyen. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
    
    extension UITableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        }
        
        func dequeueHeader<T>(ofType type: T.Type) -> T {
            return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
        }
        
        func registerCell<T>(ofType type: T.Type)
        {
            self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
        }
        
    }
    
#elseif os(OSX)
    import Cocoa
    
    extension NSTableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return make(withIdentifier: String(describing: T.self), owner: self) as! T
        }
    }
    
#endif
