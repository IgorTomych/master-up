//
//  AppDelegate.m
//  Lecture6
//
//  Created by Igor Tomych on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "DetailViewController.h"

#import <CFNetwork/CFNetwork.h>

#import "ParseOperation.h"

static NSString *const TopPaidAppsFeed =
@"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/xml";

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;

@synthesize appRecords = _appRecords;
@synthesize appListData = _appListData;
@synthesize queue = _queue;
@synthesize appListFeedConnection = _appListFeedConnection;


- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_splitViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Override point for customization after application launch.

    MasterViewController *masterViewController = [[[MasterViewController alloc] initWithNibName:@"MasterViewController_iPhone" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    self.window.rootViewController = self.navigationController;    
    
    [self.window makeKeyAndVisible];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:TopPaidAppsFeed]];
    
    self.appListFeedConnection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.appListData = [NSMutableData data];    // start off with new data
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_appListData appendData:data];  // append incoming data
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.appListFeedConnection = nil;   // release our connection
 
    NSString* output = [[NSString alloc] initWithData:_appListData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", output);
    
    // create the queue to run our ParseOperation
    self.queue = [[NSOperationQueue alloc] init];
    
    ParseOperation *parser = [[ParseOperation alloc] initWithData:_appListData delegate:self];

    [_queue addOperation:parser]; // this will start the "ParseOperation"

    [parser release];
    
    self.appListData = nil;
}

-(void)didFinishParsing:(NSArray *)appList {
    [self performSelectorOnMainThread:@selector(handleLoadedApps:) withObject:appList waitUntilDone:NO];
    
    self.queue = nil;   // we are finished
}

- (void)handleLoadedApps:(NSArray *)loadedApps
{
    self.appRecords = [[NSMutableArray alloc] init];
    
    [self.appRecords addObjectsFromArray:loadedApps];
    NSLog(@"%@", self.appRecords);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
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

@end
