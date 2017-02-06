//
//  iPCPlaylistsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCPlaylistsDisplay.h"

#import "iPCSinglePlaylistDisplay.h"

@implementation iPCPlaylistsDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		[self setQuery:[MPMediaQuery playlistsQuery]];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	[self setItems:[self.query collections]];
}

-(NSString *)itemProperty{
	return MPMediaPlaylistPropertyName;
}

-(void)centerButtonPressed{
	[self performSegueWithIdentifier:@"Playlist" sender:[self.items objectAtIndex:self.selectedRow]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	MPMediaPlaylist *playlist = (MPMediaPlaylist *)sender;
	iPCSinglePlaylistDisplay *display = segue.destinationViewController;
	display.title = [playlist valueForProperty:MPMediaPlaylistPropertyName];
	display.playlist = playlist;
}

@end