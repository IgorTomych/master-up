//
//  AppDelegate.m
//  Lecture5
//
//  Created by Igor Tomych on 7/25/12.
//  Copyright (c) 2012 Igor Tomych. All rights reserved.
//

#import "AppDelegate.h"

#import "ApplicationsListController.h"
#import "DetailViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize detailsController = _detailsController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //ipad version
        
        UISplitViewController* splitController = [[UISplitViewController alloc] init];
        
        self.viewController = [[[ApplicationsListController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
        
        self.detailsController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
        
        UINavigationController* navList = [[UINavigationController alloc] initWithRootViewController:self.viewController];
        UINavigationController* navDetails = [[UINavigationController alloc] initWithRootViewController:self.detailsController];

        
        splitController.viewControllers = [NSArray arrayWithObjects:navList, navDetails, nil];
        
        self.window.rootViewController = splitController;
        
        [splitController release];
        [navList release];
        [navDetails release];
        
    }
    else {
        //iphone version
        self.viewController = [[[ApplicationsListController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
        self.window.rootViewController = navController;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)loadApplicationFromDictionaryToDetailsController:(NSDictionary *)applicationData {
    [self.detailsController loadApplicationFromDictionary:applicationData];
}

@end
