//
//  AppDelegate.m
//  Blocstagram
//
//  Created by Edward Heywood on 22/03/2015.
//  Copyright (c) 2015 Edward Heywood. All rights reserved.
//

#import "AppDelegate.h"
#import "BLCImagesTableViewController.h"
#import "BLCLoginViewController.h"
#import "BLCDataSource.h"
#import "BLCMedia.h"
#import <UICKeyChainStore/UICKeyChainStore.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [BLCDataSource sharedInstance]; // create the data source (so it can receive the access token notification)
    
    UINavigationController *navVC = [[UINavigationController alloc] init];
    
    if (![BLCDataSource sharedInstance].accessToken) {
    BLCLoginViewController *loginVC = [[BLCLoginViewController alloc] init];
    [navVC setViewControllers:@[loginVC] animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:BLCLoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        BLCImagesTableViewController *imagesVC = [[BLCImagesTableViewController alloc] init];
        [navVC setViewControllers:@[imagesVC] animated:YES];
    }];
    
    } else {
        BLCImagesTableViewController *imagesVC = [[BLCImagesTableViewController alloc] init];
        [navVC setViewControllers:@[imagesVC] animated:YES];
    }
    
    self.window.rootViewController = navVC;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)                application:(UIApplication *)application
  performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [BLCDataSource sharedInstance];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed?access_token=%@", [UICKeyChainStore stringForKey:@"access token"]]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            NSError *errorJSON;
                                            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJSON];
                                            
                                            if (error) {
                                                completionHandler(UIBackgroundFetchResultFailed);
                                                return;
                                            }
                                            
                                            // Parse response/data and determine whether new content was available
                                            BOOL hasNewData = YES;
                                        
                                            NSString *olderHigherIdNumber = @"0";
                                            if ([BLCDataSource sharedInstance].mediaItems.count > 0)
                                            {
                                                olderHigherIdNumber = ((BLCMedia *)[[BLCDataSource sharedInstance].mediaItems firstObject]).idNumber;
                                            }
                                            
                                            NSString *newerHigherIdNumber = @"0";
                                            if (((NSArray *)responseDictionary[@"data"]).count > 0)
                                            {
                                                newerHigherIdNumber = ((NSDictionary *)[((NSArray *)responseDictionary[@"data"]) firstObject])[@"id"];
                                            }
                                            
                                            hasNewData = [newerHigherIdNumber compare:olderHigherIdNumber] == NSOrderedDescending;
                                            if (hasNewData) {
                                                [[BLCDataSource sharedInstance] parseDataFromFeedDictionary:responseDictionary fromRequestWithParameters:nil];
                                                completionHandler(UIBackgroundFetchResultNewData);
                                            } else {
                                                completionHandler(UIBackgroundFetchResultNoData);
                                            };
                                        }];
    
    // Start the task
    [task resume];
}

@end
