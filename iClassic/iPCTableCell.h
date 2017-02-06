//
//  iPCTableCell.h
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPCTableCell : UITableViewCell

+(UIImage *)disclosureImage;

@property(nonatomic,getter=isCurrentlySelected) BOOL currentlySelected;

@end
