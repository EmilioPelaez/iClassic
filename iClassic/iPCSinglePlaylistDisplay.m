//
//  iPCSinglePlaylistDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 5/1/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCSinglePlaylistDisplay.h"

#import "iPCTableCell.h"
#import "iPCDetailTableCell.h"

static NSString *CellID = @"Cell ID";

@implementation iPCSinglePlaylistDisplay

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.tableView.rowHeight = kLargeRowHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return items.count;
}

-(Class)cellClass{
	return iPCDetailTableCell.class;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	MPMediaItem *item = items[index];
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

-(void)setPlaylist:(MPMediaPlaylist *)playlist{
	_playlist = playlist;
	
	items = [playlist items];
	[self.tableView reloadData];
}

-(void)centerButtonPressed{
	MPMediaItem *nowPlaying = items[self.selectedRow];
	
	[musicPlayer setQueueWithItemCollection:self.playlist];
	[musicPlayer setNowPlayingItem:nowPlaying];
	[musicPlayer play];
	
	[self.displayStack showNowPlaying];
}

@end
