//
//  iPCMenuDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCMenuDisplay.h"

#import "iPCPlaylistsDisplay.h"
#import "iPCArtistsDisplay.h"
#import "iPCAlbumsDisplay.h"
#import "iPCSongsDisplay.h"
#import "iPCSettingsDisplay.h"
#import "iPCStatusBar.h"
#import "iPCDetailTableCell.h"

@interface iPCMenuDisplay ()

@property(nonatomic, strong) NSArray *itemsArrays;

@end

@implementation iPCMenuDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		_titles = @[@"Now Playing",
								@"Playlists",
								@"Artists",
								@"Albums",
								@"Songs",
								@"Settings"];
		
		imageNames = @[@"NowPlaying",
									 @"Playlists",
									 @"Artists",
									 @"Albums",
									 @"Songs",
									 @"Settings"];
		
		_itemsArrays = @[@"",	//	Dummy object to make it easier to work with the indices
										 [[MPMediaQuery playlistsQuery] collections],
										 [[MPMediaQuery artistsQuery] collections],
										 [[MPMediaQuery albumsQuery] collections],
										 [[MPMediaQuery songsQuery] items]];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.tableView.rowHeight = kLargeRowHeight;
}

-(Class)cellClass{
	return iPCDetailTableCell.class;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.titles.count;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	cell.textLabel.text = self.titles[index];
	cell.detailTextLabel.text = nil;
	cell.imageView.image = [UIImage imageNamed:imageNames[index]];
	
//	if(index != self.selectedRow) return;
	
	switch(index){
  case 0:{
		MPMediaItem *nowPlaying = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
		NSString *title = nowPlaying.title;
		if(nowPlaying.artist)
			title = [NSString stringWithFormat:@"%@ - %@", title, nowPlaying.artist];
		cell.detailTextLabel.text = title;
		break;
	}
		case 1: case 2: case 3: case 4:{
			NSUInteger count = [self.itemsArrays[index] count];
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)count, self.titles[index]];
			break;
		}
	}
}

-(void)centerButtonPressed{
	switch (self.selectedRow) {
		case 0:
			[self.displayStack showNowPlaying];
			break;
		default:
			[self performSegueWithIdentifier:self.titles[self.selectedRow] sender:nil];
			break;
	}
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	iPCDisplay *display = segue.destinationViewController;
	display.title = segue.identifier;
}

@end
