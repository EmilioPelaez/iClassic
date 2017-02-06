//
//  iPCArtistsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCArtistsDisplay.h"

#import "iPCAlbumsDisplay.h"

@implementation iPCArtistsDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setQuery:[MPMediaQuery artistsQuery]];
		[self setShowAllRow:YES];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	[self setItems:[self.query collections]];
}

-(NSString *)segueIdentifier{
	return @"Albums";
}

-(NSString *)itemProperty{
	return MPMediaItemPropertyArtist;
}
-(BOOL)useRepresentativeItem{
	return YES;
}

@end
