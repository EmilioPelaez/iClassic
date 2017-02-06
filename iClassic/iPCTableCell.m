//
//  iPCTableCell.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCTableCell.h"

@implementation iPCTableCell

+(UIImage *)disclosureImage{
	static UIImage *disclosure;
	if(!disclosure) disclosure = [[UIImage imageNamed:@"Disclosure"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	return disclosure;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self.textLabel setFont:[UIFont boldSystemFontOfSize:13]];
		
		if(style != UITableViewCellStyleDefault)
			[self.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
	}
	return self;
}

-(void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType{
	if(accessoryType == UITableViewCellAccessoryDisclosureIndicator){
		UIImageView *view = [[UIImageView alloc] initWithImage:[iPCTableCell disclosureImage]];
		view.tintColor = self.imageView.tintColor;
		[self setAccessoryView:view];
	}else{
		return [super setAccessoryType:accessoryType];
	}
}

-(void)setCurrentlySelected:(BOOL)currentlySelected{
	_currentlySelected = currentlySelected;
	
	UIColor *color = [[iPCColorsManager sharedInstance] themeColor];
	
	if(currentlySelected) {
		UIColor *contrastingBlackOrWhiteColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:color isFlat:YES];
		
		self.backgroundColor = self.contentView.backgroundColor = color;
		self.textLabel.textColor = contrastingBlackOrWhiteColor;
		self.imageView.tintColor = self.accessoryView.tintColor = contrastingBlackOrWhiteColor;
	}else{
		self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
		self.textLabel.textColor = [UIColor flatBlackColor];
		self.imageView.tintColor = self.accessoryView.tintColor = color;
	}
}

@end