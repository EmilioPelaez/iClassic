//
//  iPCQueryDisplay.h
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "iPCTableDisplay.h"

@interface iPCQueryDisplay : iPCTableDisplay

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) MPMediaQuery *query;

@property(nonatomic) BOOL showAllRow;

-(NSString *)segueIdentifier;

-(NSString *)itemProperty;
-(BOOL)useRepresentativeItem;

@end
