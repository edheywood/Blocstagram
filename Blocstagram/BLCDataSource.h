//
//  BLCDataSource.h
//  Blocstagram
//
//  Created by Edward Heywood on 22/03/2015.
//  Copyright (c) 2015 Edward Heywood. All rights reserved.
//

#import <Foundation/Foundation.h>

 @class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);

@interface BLCDataSource : NSObject


 +(instancetype) sharedInstance;
+ (NSString *) instagramClientID;
@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

 - (void) deleteMediaItem:(BLCMedia *)item;

- (void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;


@end
