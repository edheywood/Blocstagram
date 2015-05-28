//
//  BLCComment.h
//  Blocstagram
//
//  Created by Edward Heywood on 22/03/2015.
//  Copyright (c) 2015 Edward Heywood. All rights reserved.
//

#import <Foundation/Foundation.h>

 @class BLCUser;

 @interface BLCComment : NSObject <NSCoding>

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *from;
@property (nonatomic, strong) NSString *text;

@end
