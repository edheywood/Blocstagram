//
//  BLCDataSource.h
//  Blocstagram
//
//  Created by Edward Heywood on 22/03/2015.
//  Copyright (c) 2015 Edward Heywood. All rights reserved.
//

#import <Foundation/Foundation.h>

 @class BLCMedia;

@interface BLCDataSource : NSObject

 +(instancetype) sharedInstance;
 @property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

 - (void) deleteMediaItem:(BLCMedia *)item;

@end
