//
//  CollectionView+.swift
//  Tutor
//
//  Created by Tuyen on 2/23/18.
//  Copyright © 2018 Tuyen. All rights reserved.
//

import UIKit

import Foundation

#if os(iOS)
    import UIKit
    
    extension UICollectionView {
        func dequeueCell<T>(ofType type: T.Type,indexPath: IndexPath) -> T {
            return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath)  as! T
        }
        
        func dequeueHeader<T>(ofType type: T.Type,indexPath: IndexPath) -> T {
            return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self), for: indexPath)  as! T
        }
        
        func dequeueFooter<T>(ofType type: T.Type,indexPath: IndexPath) -> T {
            return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self), for: indexPath)  as! T
        }
        
        func registerCell<T>(ofType type: T.Type)
        {
            self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
        }
        func registerHeader<T>(ofType type: T.Type)
        {
            self.register(UINib(nibName: String(describing: T.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self))
        }
        
        func registerFooter<T>(ofType type: T.Type)
        {
            self.register(UINib(nibName: String(describing: T.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self))
        }
        
    }
#endif
