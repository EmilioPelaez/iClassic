//
//  iPCSettingsTableCell.m
//  iClassic
//
//  Created by Emilio Peláez on 6/9/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCSettingsTableCell.h"

@implementation iPCSettingsTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	return [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
}

-(void)setCurrentlySelected:(BOOL)currentlySelected{
	[super setCurrentlySelected:currentlySelected];
	
	self.detailTextLabel.textColor = self.textLabel.textColor;
}

@end
