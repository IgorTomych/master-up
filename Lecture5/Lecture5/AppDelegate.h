//
//  AppDelegate.h
//  Lecture5
//
//  Created by Igor Tomych on 7/25/12.
//  Copyright (c) 2012 Igor Tomych. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplicationsListController;
@class DetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ApplicationsListController *viewController;
@property (strong, nonatomic) DetailViewController *detailsController;


-(void)loadApplicationFromDictionaryToDetailsController:(NSDictionary *)applicationData;
@end
