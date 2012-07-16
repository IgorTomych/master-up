//
//  AppDelegate.h
//  Lecture6
//
//  Created by Igor Tomych on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseOperation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, ParseOperationDelegate> {
    NSMutableData           *_appListData;
    NSURLConnection         *_appListFeedConnection;
    NSMutableArray          *_appRecords;
    NSOperationQueue		*_queue;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UISplitViewController *splitViewController;

@property (strong, nonatomic) NSMutableArray *appRecords;
@property (strong, nonatomic) NSMutableData *appListData;

@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSURLConnection *appListFeedConnection;


@end
