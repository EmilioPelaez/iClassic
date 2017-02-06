//
//  iPCPlayPauseView.m
//  iClassic
//
//  Created by Emilio Peláez on 6/12/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCPlayPauseView.h"

@implementation iPCPlayPauseView

-(void)tintColorDidChange{
	[super tintColorDidChange];
	
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
	[self.tintColor setStroke];
	
	UIBezierPath* arrowPath = UIBezierPath.bezierPath;
	[arrowPath moveToPoint: CGPointMake(0.5, 0.5)];
	[arrowPath addLineToPoint: CGPointMake(0.5, 8.5)];
	[arrowPath addLineToPoint: CGPointMake(7.5, 4.5)];
	[arrowPath addLineToPoint: CGPointMake(0.5, 0.5)];
	[arrowPath closePath];
	arrowPath.lineWidth = 1;
	[arrowPath stroke];
	
	UIBezierPath* leftRectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(8.5, 0.5, 3, 8)];
	leftRectanglePath.lineWidth = 1;
	[leftRectanglePath stroke];
	
	UIBezierPath* rightRectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(13.5, 0.5, 3, 8)];
	rightRectanglePath.lineWidth = 1;
	[rightRectanglePath stroke];
}

@end
