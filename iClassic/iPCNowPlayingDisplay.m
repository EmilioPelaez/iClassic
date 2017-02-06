//
//  iPCNowPlayingDisplay.m
//  iPodClassic
//
//  Created by Emilio Peláez on 8/28/10.
//  Copyright 2010 Kernel Panic. All rights reserved.
//

/*
 switch(musicPlayer.playbackState){
 case MPMusicPlaybackStatePaused:
 case MPMusicPlaybackStateInterrupted:
 case MPMusicPlaybackStatePlaying:
 case MPMusicPlaybackStateSeekingBackward:
 case MPMusicPlaybackStateSeekingForward:
 case MPMusicPlaybackStateStopped:
 break;
 }
 */

#import "iPCNowPlayingDisplay.h"

#import "iPCLyricsDisplay.h"

@interface iPCNowPlayingDisplay (){
	NSArray *starsArray;
}

@end

@implementation iPCNowPlayingDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		starsArray = @[@"・・・・・",
									 @"★・・・・",
									 @"★★・・・",
									 @"★★★・・",
									 @"★★★★・",
									 @"★★★★★"];
		
		[self setIdentifier:@"Now Playing Display"];
		[self setCacheSize:1];
		
		[musicPlayer beginGeneratingPlaybackNotifications];
		[[NSNotificationCenter defaultCenter] addObserverForName:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
																											object:nil
																											 queue:nil
																									usingBlock:^(NSNotification *note){
																										[self updateSong];
																									}];
		[[NSNotificationCenter defaultCenter] addObserverForName:MPMusicPlayerControllerPlaybackStateDidChangeNotification
																											object:nil
																											 queue:nil
																									usingBlock:^(NSNotification *note){
																										[self updateSong];
																										switch (musicPlayer.playbackState) {
																											case MPMusicPlaybackStateSeekingBackward:
																											case MPMusicPlaybackStateSeekingForward:
																												[self didBeginSeeking];
																												break;
																											default:
																												[self didEndSeeking];
																												break;
																										}
																									}];
		
		[[NSNotificationCenter defaultCenter] addObserverForName:@"UpdateShuffleRepeatIcons"
																											object:nil
																											 queue:nil
																									usingBlock:^(NSNotification *note){
																										[self updateShuffleRepeatIcons];
																									}];
		
		artworkPlaceholder = [[UIImage imageNamed:@"NoArtwork"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		
		[self updateSong];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.songNameLabel.font = [UIFont boldSystemFontOfSize:16];
	self.albumLabel.font = self.artistLabel.font = self.starsLabel.font = self.numberLabel.font = [UIFont boldSystemFontOfSize:13];
	
	self.songNameLabel.textColor = self.numberLabel.textColor = [UIColor flatBlackColorDark];
	self.albumLabel.textColor = self.artistLabel.textColor = self.starsLabel.textColor = [UIColor colorWithWhite:.4 alpha:1];
	
	[self updateSong];
}

-(void)updateSong{
	[self setNowPlayingItem:[musicPlayer nowPlayingItem]];
	if(self.nowPlayingItem){
		[barTimer invalidate];
		barTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateInfoBar) userInfo:nil repeats:YES];
		
		NSTimeInterval totalPlaybackTime = self.nowPlayingItem.playbackDuration;
		[self.infoBar setTotalPlaybackTime:totalPlaybackTime];
		[self updateInfoBar];
		
		MPMediaItemArtwork *artwork = self.nowPlayingItem.artwork;
		UIImage *artworkImage = [artwork imageWithSize:self.artworkImageView.bounds.size];
		if(artworkImage)
			[self.artworkImageView setImage:artworkImage];
		else
			[self.artworkImageView setImage:artworkPlaceholder];
		
		self.songNameLabel.text	= self.nowPlayingItem.title;
		self.artistLabel.text		= self.nowPlayingItem.artist;
		self.albumLabel.text			= self.nowPlayingItem.title;
		
		NSUInteger rating = self.nowPlayingItem.rating;
		if(rating > 5) rating = 0;
		self.starsLabel.text = starsArray[rating];
		
		NSInteger songNumber = self.nowPlayingItem.albumTrackNumber;
		NSInteger songCount = self.nowPlayingItem.albumTrackCount;
		
		if(songNumber > 0){
			if(songCount > 0)
				self.numberLabel.text = [NSString stringWithFormat:@"%li of %li", (long)songNumber, (long)songCount];
			else
				self.numberLabel.text = [NSString stringWithFormat:@"Track no. %li", (long)songNumber];
		}else{
			self.numberLabel.text = nil;
		}
		
	}else{
		[barTimer invalidate];
		barTimer = nil;
		
		self.artworkImageView.image = artworkPlaceholder;
		self.songNameLabel.text	= @"No song";
		self.artistLabel.text		= @"No artist";
		self.albumLabel.text			= @"No album";
		self.starsLabel.text			= @"★★★★★";
		self.numberLabel.text		= @"0 of 0";
		
		[self.repeatImage setImage:[[UIImage imageNamed:@"Repeat"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
		
		[self.shuffleImage setTintColor:[UIColor colorWithWhite:.75 alpha:1]];
		[self.repeatImage setTintColor:[UIColor colorWithWhite:.75 alpha:1]];
	}
}

-(void)updateShuffleRepeatIcons{
	switch(musicPlayer.shuffleMode){
		case MPMusicShuffleModeOff:
			[self.shuffleImage setTintColor:[UIColor colorWithWhite:.75 alpha:1]];
			break;
		case MPMusicShuffleModeDefault:
		case MPMusicShuffleModeSongs:
		case MPMusicShuffleModeAlbums:
			[self.shuffleImage setTintColor:nil];
			break;
	}
	
	switch(musicPlayer.repeatMode){
		case MPMusicRepeatModeNone:
			[self.repeatImage setImage:[[UIImage imageNamed:@"Repeat"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
			[self.repeatImage setTintColor:[UIColor colorWithWhite:.75 alpha:1]];
			break;
		case MPMusicRepeatModeOne:
			[self.repeatImage setImage:[[UIImage imageNamed:@"RepeatOne"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
			[self.repeatImage setTintColor:nil];
			break;
		case MPMusicRepeatModeDefault:
		case MPMusicRepeatModeAll:
			[self.repeatImage setImage:[[UIImage imageNamed:@"Repeat"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
			[self.repeatImage setTintColor:nil];
			break;
			
		default:
			break;
	}
}

-(void)updateInfoBar{
	NSTimeInterval playbackTime = musicPlayer.currentPlaybackTime;
	[self.infoBar setCurrentPlaybackTime:playbackTime];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self.songNameLabel resetLabel];
	[self.artistLabel resetLabel];
	[self.albumLabel resetLabel];
}

-(void)receivedOffset:(float)offset{
//	float volume = [musicPlayer volume] + (offset / 5.0);
//	volume = MAX(volume, 0);
//	volume = MIN(volume, 1);
//	
//	[musicPlayer setVolume:volume];
}

-(void)centerButtonPressed{
	NSString *lyricsText = self.nowPlayingItem.lyrics;
	if(lyricsText.length == 0) return;
	
	[self performSegueWithIdentifier:@"Lyrics" sender:lyricsText];
}

-(void)didBeginSeeking{
	[seekingTimer invalidate];
	seekingTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateInfoBar) userInfo:nil repeats:YES];
}

-(void)didEndSeeking{
	[seekingTimer invalidate];
	seekingTimer = nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	iPCLyricsDisplay *display = segue.destinationViewController;
	
	display.lyricsText = [NSString stringWithFormat:@"\n%@\n", sender];
}

@end
