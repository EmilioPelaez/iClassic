//
//  iPCSongsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCSongsDisplay.h"

#import "iPCDetailTableCell.h"

static NSString *CellID = @"Cell ID";

@implementation iPCSongsDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setQuery:[MPMediaQuery songsQuery]];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	[self setItems:[self.query items]];
	
	[self.tableView setRowHeight:kLargeRowHeight];
}

-(Class)cellClass{
	return iPCDetailTableCell.class;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	MPMediaItem *item = self.items[index];
	NSString *artist = item.artist;
	NSString *album = item.title;
	
	[cell.textLabel setText:[item valueForProperty:MPMediaItemPropertyTitle]];
	if(artist && album)
		[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ - %@", artist, album]];
	else if(artist)
		[cell.detailTextLabel setText:artist];
	else if(album)
		[cell.detailTextLabel setText:album];
	else
		[cell.detailTextLabel setText:@"  "];
}

-(void)centerButtonPressed{
	MPMediaItem *nowPlaying = [self.items objectAtIndex:self.selectedRow];
	
	[musicPlayer setQueueWithQuery:self.query];
	[musicPlayer setNowPlayingItem:nowPlaying];
	[musicPlayer play];
	
	[self.displayStack showNowPlaying];
}

@end
