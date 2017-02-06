//
//  iPCMusicPlayer.m
//  iClassic
//
//  Created by Emilio Peláez on 6/10/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCMusicPlayer.h"

@interface iPCMusicPlayer (){
	MPMusicPlayerController *musicPlayer;
}

@end

@implementation iPCMusicPlayer

+(instancetype)sharedInstance{
	static id sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [self new];
	});
	
	return sharedInstance;
}

-(instancetype)init{
	self = [super init];
	if(self){
		musicPlayer = [MPMusicPlayerController systemMusicPlayer];
	}
	return self;
}

-(void)bottomAction:(iPCButtonAction)action{
	switch(action){
		case iPCButtonActionTap:
			switch(musicPlayer.playbackState){
				case MPMusicPlaybackStatePaused:
					return [musicPlayer play];
				case MPMusicPlaybackStatePlaying:
					return [musicPlayer pause];
				case MPMusicPlaybackStateInterrupted:
				case MPMusicPlaybackStateSeekingBackward:
				case MPMusicPlaybackStateSeekingForward:
				case MPMusicPlaybackStateStopped:
					break;
			}
			break;
		case iPCButtonActionBeginHold:
			[musicPlayer stop];
			break;
		case iPCButtonActionEndHold:
			break;
			
		default:
			break;
	}
}

-(void)leftAction:(iPCButtonAction)action{
	switch(action){
		case iPCButtonActionTap:
			switch(musicPlayer.playbackState){
				case MPMusicPlaybackStateInterrupted:
				case MPMusicPlaybackStateSeekingBackward:
				case MPMusicPlaybackStateSeekingForward:
				case MPMusicPlaybackStateStopped:
					break;
				case MPMusicPlaybackStatePaused:
				case MPMusicPlaybackStatePlaying:
					if([musicPlayer currentPlaybackTime] > 5) [musicPlayer skipToBeginning];
					else [musicPlayer skipToPreviousItem];
					break;
			}
			break;
		case iPCButtonActionBeginHold:
			[musicPlayer beginSeekingBackward];
			//[self didBeginSeeking];
			break;
		case iPCButtonActionEndHold:
			[musicPlayer endSeeking];
			//[self didEndSeeking];
			break;
			
		default:
			break;
	}
}

-(void)rightAction:(iPCButtonAction)action{
	switch(action){
		case iPCButtonActionTap:
			switch(musicPlayer.playbackState){
				case MPMusicPlaybackStateInterrupted:
				case MPMusicPlaybackStateSeekingBackward:
				case MPMusicPlaybackStateSeekingForward:
				case MPMusicPlaybackStateStopped:
					break;
				case MPMusicPlaybackStatePaused:
				case MPMusicPlaybackStatePlaying:
					[musicPlayer skipToNextItem];
					break;
			}
			break;
		case iPCButtonActionBeginHold:
			[musicPlayer beginSeekingForward];
			//[self didBeginSeeking];
			break;
		case iPCButtonActionEndHold:
			[musicPlayer endSeeking];
			//[self didEndSeeking];
			break;
			
		default:
			break;
	}
}

@end
