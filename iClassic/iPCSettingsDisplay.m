//
//  iPCSettingsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 07/05/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCSettingsDisplay.h"

#import "iPCTableCell.h"
#import "iPCThemesDisplay.h"
#import "iPCStatusBar.h"
#import "iPCSettingsTableCell.h"
#import "iPCColorsManager.h"

NSString *stringFromShuffleMode(MPMusicShuffleMode mode){
	switch (mode) {
		case MPMusicShuffleModeDefault: return NSLocalizedString(@"Default", @"Default");
		case MPMusicShuffleModeOff: return NSLocalizedString(@"Off", @"Off");
		case MPMusicShuffleModeSongs: return NSLocalizedString(@"Songs", @"Songs");
		case MPMusicShuffleModeAlbums: return NSLocalizedString(@"Albums", @"Albums");
	}
	
	return nil;
}

NSString *stringFromRepeatMode(MPMusicRepeatMode mode){
	switch (mode) {
		case MPMusicRepeatModeDefault: return NSLocalizedString(@"Default", @"Default");
		case MPMusicRepeatModeNone: return NSLocalizedString(@"Off", @"Off");
		case MPMusicRepeatModeOne: return NSLocalizedString(@"One", @"One");
		case MPMusicRepeatModeAll: return NSLocalizedString(@"All", @"All");
	}
	
	return nil;
}

@implementation iPCSettingsDisplay

static NSString *CellID = @"Cell ID";

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		titles = @[NSLocalizedString(@"Shuffle", @"Shuffle"),
							 NSLocalizedString(@"Repeat", @"Repeat"),
							 NSLocalizedString(@"Theme", @"Theme"),
							 NSLocalizedString(@"Face Color", @"Face Color"),
							 NSLocalizedString(@"Credits", @"Credits")];
		
		imageNames = @[@"Shuffle",
									 @"Repeat",
									 @"Color",
									 @"Theme",
									 @"Artists"];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.tableView.rowHeight = kLargeRowHeight;
}

-(Class)cellClass{
	return iPCSettingsTableCell.class;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return titles.count;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	cell.textLabel.text = [titles objectAtIndex:index];
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	switch(index){
		case 0:
			[cell.detailTextLabel setText:stringFromShuffleMode([musicPlayer shuffleMode])];
			break;
		case 1:
			[cell.detailTextLabel setText:stringFromRepeatMode([musicPlayer repeatMode])];
			break;
		case 2:
			[cell.detailTextLabel setText:nil];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 3:
			switch ([[iPCColorsManager sharedInstance] theme]) {
				case iPCThemeLightFace:
					[cell.detailTextLabel setText:NSLocalizedString(@"Light", @"Light")];
					break;
				case iPCThemeDarkFace:
					[cell.detailTextLabel setText:NSLocalizedString(@"Dark", @"Dark")];
					break;
			}
		case 4:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		default:
			break;
	}
	
	cell.imageView.image = [UIImage imageNamed:imageNames[index]];
}

-(void)centerButtonPressed{
	switch(self.selectedRow){
		case 0:
			[musicPlayer setShuffleMode:(musicPlayer.shuffleMode + 1 < 3) ? musicPlayer.shuffleMode + 1 : 1];
			[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedRow - self.rowOffset inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
			[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"UpdateShuffleRepeatIcons" object:nil]];
			break;
		case 1:
			[musicPlayer setRepeatMode:(musicPlayer.repeatMode + 1 < 4) ? musicPlayer.repeatMode + 1 : 1];
			[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedRow - self.rowOffset inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
			[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"UpdateShuffleRepeatIcons" object:nil]];
			break;
		case 2:{
			[self performSegueWithIdentifier:@"Themes" sender:nil];
			break;
		}
		case 3:{
			iPCColorsManager *colors = [iPCColorsManager sharedInstance];
			colors.theme = ++colors.theme % 2;
			
			[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedRow - self.rowOffset inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
		}
		case 4:
			[self performSegueWithIdentifier:@"Credits" sender:nil];
			break;
		default:
			break;
	}
}

@end
