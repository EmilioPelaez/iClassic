//
//  iPCDetailTableCell.m
//  iClassic
//
//  Created by Emilio Peláez on 6/9/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCDetailTableCell.h"

@implementation iPCDetailTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}

-(void)setCurrentlySelected:(BOOL)currentlySelected{
	[super setCurrentlySelected:currentlySelected];
	
	self.detailTextLabel.textColor = self.textLabel.textColor;
}

@end
