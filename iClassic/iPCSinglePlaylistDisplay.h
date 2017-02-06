//
//  iPCSinglePlaylistDisplay.h
//  iClassic
//
//  Created by Emilio Peláez on 5/1/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "iPCTableDisplay.h"

@interface iPCSinglePlaylistDisplay : iPCTableDisplay{
	NSArray *items;
}

@property(nonatomic, strong) MPMediaPlaylist *playlist;

@end
