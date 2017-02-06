//
//  iPCAlbumsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCAlbumsDisplay.h"

#import "iPCSongsDisplay.h"

@implementation iPCAlbumsDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setQuery:[MPMediaQuery albumsQuery]];
		[self setShowAllRow:YES];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	[self setItems:[self.query collections]];
}

-(NSString *)segueIdentifier{
	return @"Songs";
}

-(NSString *)itemProperty{
	return MPMediaItemPropertyAlbumTitle;
}
-(BOOL)useRepresentativeItem{
	return YES;
}

@end
