//
//  CustomCollectionView.swift
//  Charger
//
//  Created by Ceren Yaşa on 16.07.2022.
//

import Foundation
import UIKit

class CustomLayout: UICollectionViewLayout {

    let CELL_HEIGHT: CGFloat = 50
    let CELL_WIDTH: CGFloat = 180


    var cellAttributesDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    var contentSize = CGSize.zero

    override var collectionViewContentSize: CGSize {
        get {
            return contentSize
        }
    }

    var dataSourceDidUpdate = true

    override func prepare() {

        let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.height
        let NAV_BAR_HEIGHT = UINavigationController().navigationBar.frame.size.height

        collectionView?.bounces = false

        if !dataSourceDidUpdate {

            let yOffSet = collectionView!.contentOffset.y

            for section in 0 ..< collectionView!.numberOfSections {
                if section == 0 {
                    for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                        let cellIndexPath = IndexPath(item: item, section: section)
                        if let attrs = cellAttributesDictionary[cellIndexPath] {
                            var frame = attrs.frame
                            frame.origin.y = yOffSet + STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT
                            attrs.frame = frame
                        }
                    }
                }
            }
           return
        }

        dataSourceDidUpdate = false

        for section in 0 ..< collectionView!.numberOfSections {
            for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                let cellIndexPath = IndexPath(item: item, section: section)
                let xPos = CGFloat(item) * CELL_WIDTH
                let yPos = CGFloat(section) * CELL_HEIGHT

                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndexPath)
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: CELL_WIDTH, height: CELL_HEIGHT)

                // Determine zIndex based on cell type.
                if section == 0 && item == 0 {
                    cellAttributes.zIndex = 4
                } else if section == 0 {
                    cellAttributes.zIndex = 3
                } else if item == 0 {
                    cellAttributes.zIndex = 2
                } else {
                    cellAttributes.zIndex = 1
                }

                cellAttributesDictionary[cellIndexPath] = cellAttributes

            }
        }

        let contentWidth = CGFloat(collectionView!.numberOfItems(inSection: 0)) * CELL_WIDTH
        let contentHeight = CGFloat(collectionView!.numberOfSections) * CELL_HEIGHT
        contentSize = CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()

        for cellAttrs in cellAttributesDictionary.values {
            if rect.intersects(cellAttrs.frame) {
                attributesInRect.append(cellAttrs)
            }
        }

        return attributesInRect
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributesDictionary[indexPath]
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
