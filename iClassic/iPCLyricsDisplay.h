//
//  iPCLyricsDisplay.h
//  iClassic
//
//  Created by Emilio Peláez on 5/4/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCDisplay.h"

@interface iPCLyricsDisplay : iPCDisplay {
}

@property(nonatomic, copy) NSString *lyricsText;

@property(nonatomic, weak) IBOutlet UILabel *lyricsLabel;
@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end
