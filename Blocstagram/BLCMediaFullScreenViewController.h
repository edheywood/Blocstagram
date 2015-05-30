//
//  BLCMediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Ed on 28/05/2015.
//  Copyright (c) 2015 Edward Heywood. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, retain) NSString *data;


- (instancetype) initWithMedia:(BLCMedia *)media;

- (void) centerScrollView;

@end
