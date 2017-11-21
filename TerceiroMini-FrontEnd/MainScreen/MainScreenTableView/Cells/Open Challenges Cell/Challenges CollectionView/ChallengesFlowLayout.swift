//
//  ChallengesFlowLayout.swift
//  TerceiroMini-FrontEnd
//
//  Created by Leonel Menezes on 20/11/2017.
//  Copyright © 2017 BEPID. All rights reserved.
//

import UIKit

class ChallengesFlowLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    
    var standartItemScale = 0.83
    
    override func prepare() {
        super.prepare()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
        }
        
        return attributesCopy
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let collectionCenter = collectionView!.frame.size.width/2
        let offset = collectionView!.contentOffset.x
        let normalizedCenter = attributes.center.x - offset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing//OBS pode ser min interitem
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        let ratio = (maxDistance - distance)/maxDistance
        
        let scale = (ratio * CGFloat(1 - self.standartItemScale) + CGFloat(self.standartItemScale))
        
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1.0)
        
        
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        let layoutAttributes = self.layoutAttributesForElements(in: collectionView!.bounds)
//        let center = (collectionView?.bounds.size.width)!/2
//        let proposedContentOffsetOrigin = proposedContentOffset.x + center
//
//        let closest = layoutAttributes!.sorted { abs($0.center.x - proposedContentOffsetOrigin) < abs($1.center.x - proposedContentOffsetOrigin)
//            }.first ?? UICollectionViewLayoutAttributes()
//        let targetContentOffset = CGPoint(x: floor(closest.center.x - center), y: proposedContentOffset.x)
//        return targetContentOffset
//    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        if let collectionViewBounds = self.collectionView?.bounds
        {
            let halfWidthOfVC = collectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds)
            {
                var candidateAttribute : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells
                {
                    let candAttr : UICollectionViewLayoutAttributes? = candidateAttribute
                    if candAttr != nil
                    {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttr!.center.x - proposedContentOffsetCenterX
                        if fabs(a) < fabs(b)
                        {
                            candidateAttribute = attributes
                        }
                    }
                    else
                    {
                        candidateAttribute = attributes
                        continue
                    }
                }
                
                if candidateAttribute != nil
                {
                    return CGPoint(x: candidateAttribute!.center.x - halfWidthOfVC, y: proposedContentOffset.y);
                }
            }
        }
        return CGPoint.zero
    }

}
