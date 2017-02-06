//
//  iPCArtworkView.m
//  iClassic
//
//  Created by Emilio Peláez on 06/05/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCArtworkView.h"

@implementation iPCArtworkView

#define kReflectionGap 0

+(CGSize)suggestedSizeForArtworkSize:(CGSize)artworkSize{
	return CGSizeMake(artworkSize.width, artworkSize.height * 1.3 + kReflectionGap);
}

-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if(self){
		[self setBackgroundColor:[UIColor whiteColor]];
	}
	return self;
}

-(void)setArtworkImage:(UIImage *)artworkImage{
	NSAssert(artworkImage, @"Artwork Image is nil");
	
	_artworkImage = artworkImage;
	
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
	NSAssert(rect.size.width < rect.size.height, @"This view can't be fat");
	
	[self.artworkImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.width)];
	
	CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextDrawImage(context, CGRectMake(0, rect.size.width + kReflectionGap, rect.size.width, rect.size.width), self.artworkImage.CGImage);
	UIColor *gradBegin = [UIColor colorWithWhite:1 alpha:0];
	UIColor *gradMed = [UIColor colorWithWhite:1 alpha:.75];
	UIColor *gradEnd = [UIColor colorWithWhite:1 alpha:1];
	NSArray *gradColours = @[(id)gradBegin.CGColor, (id)gradBegin.CGColor, (id)gradMed.CGColor, (id)gradEnd.CGColor];
	CGFloat gradLocs[] = { 0, (rect.size.width)/rect.size.height, (rect.size.width + kReflectionGap)/rect.size.height, 1};
	CGGradientRef gradient = CGGradientCreateWithColors(colourSpace, (__bridge CFArrayRef)gradColours, gradLocs);
	CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, self.frame.size.height), 0);
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colourSpace);
	
	//CGContextScaleCTM(context, 0, -1);
	//CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.width), self.artworkImage.CGImage);

}

@end
