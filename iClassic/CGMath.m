//
//  CGMath.m
//  PolygonCollision
//
//  Created by Emilio Peláez on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CGMath.h"

CGPoint CGPointAdd(CGPoint point1, CGPoint point2){
	return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

CGPoint CGPointAddBatch(CGPoint *points, NSInteger count){
	CGFloat x = 0;
	CGFloat y = 0;
	for(NSInteger i = 0; i < count; i++){
		x += points[i].x;
		y += points[i].y;
	}
	return CGPointMake(x, y);
}

CGPoint CGPointSubstract(CGPoint point1, CGPoint point2){
	return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}


CGPoint CGPointMultiply(CGPoint point, CGFloat scalar){
	return CGPointMake(point.x * scalar, point.y * scalar);
}


CGFloat CGPointDotProduct(CGPoint point1, CGPoint point2){
	return point1.x * point2.x + point1.y * point2.y;
}

CGFloat CGPointGetMagnitude(CGPoint point){
	return sqrtf((point.x * point.x) + (point.y * point.y));
}

CGPoint CGPointGetNormalized(CGPoint point){
	CGFloat magnitude = CGPointGetMagnitude(point);
	CGFloat x = point.x/magnitude;
	CGFloat y = point.y/magnitude;
	return CGPointMake(x, y);
}