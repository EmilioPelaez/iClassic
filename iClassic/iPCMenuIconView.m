//
//  iPCMenuIconView.m
//  iClassic
//
//  Created by Emilio Peláez on 6/12/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCMenuIconView.h"

@implementation iPCMenuIconView

-(void)tintColorDidChange{
	[super tintColorDidChange];
	
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
	[self.tintColor setStroke];
	
	UIBezierPath* topRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, 13, 2) cornerRadius: 1];
	topRectanglePath.lineWidth = 1;
	[topRectanglePath stroke];
	
	UIBezierPath* middleRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 4.5, 13, 2) cornerRadius: 1];
	middleRectanglePath.lineWidth = 1;
	[middleRectanglePath stroke];
	
	UIBezierPath* bottomRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 8.5, 13, 2) cornerRadius: 1];
	bottomRectanglePath.lineWidth = 1;
	[bottomRectanglePath stroke];
}

@end
