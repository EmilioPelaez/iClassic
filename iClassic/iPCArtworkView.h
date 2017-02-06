//
//  iPCArtworkView.h
//  iClassic
//
//  Created by Emilio Peláez on 06/05/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPCArtworkView : UIView

@property(nonatomic, strong) UIImage *artworkImage;

+(CGSize)suggestedSizeForArtworkSize:(CGSize)artworkSize;

@end
