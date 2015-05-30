//
//  BLCMediaFullScreenAnimator.h
//  Blocstagram
//
//  Created by Ed on 28/05/2015.
//  Copyright (c) 2015 Edward Heywood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLCMediaFullScreenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, weak) UIImageView *cellImageView;

@end
