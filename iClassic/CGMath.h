//
//  CGMath.h
//  PolygonCollision
//
//  Created by Emilio Peláez on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

CGPoint CGPointAdd(CGPoint point1, CGPoint point2);
CGPoint CGPointAddBatch(CGPoint *points, NSInteger count);
CGPoint CGPointSubstract(CGPoint point1, CGPoint point2);

CGPoint CGPointMultiply(CGPoint point1, CGFloat scalar);

CGFloat CGPointDotProduct(CGPoint point1, CGPoint point2);

CGFloat CGPointGetMagnitude(CGPoint point);

CGPoint CGPointGetNormalized(CGPoint point);