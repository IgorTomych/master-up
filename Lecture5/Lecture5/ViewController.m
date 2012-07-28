//
//  ViewController.m
//  Lecture5
//
//  Created by Igor Tomych on 7/25/12.
//  Copyright (c) 2012 Igor Tomych. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/UIImageView+AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize storeTopApps;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@"%d", [self.storeTopApps count]);
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=50/json"];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //downloaded successfuly
        
        self.storeTopApps = [NSArray arrayWithArray:[[responseObject objectForKey:@"feed"] objectForKey:@"entry"]];
        
        NSLog(@"downloaded! %d", [storeTopApps count]);
        
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Not downloaded!");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    //start downloading
    [operation start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //release
    [url release];
    [request release];
    [operation release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [storeTopApps count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    
    NSDictionary* storeObject = (NSDictionary*)[self.storeTopApps objectAtIndex:indexPath.row];
    NSLog(@"%@ %d", [[storeObject objectForKey:@"title"] objectForKey:@"label"], indexPath.row);
    cell.textLabel.text = [[storeObject objectForKey:@"title"] objectForKey:@"label"];

    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[[[storeObject objectForKey:@"im:image"] objectAtIndex:0] objectForKey:@"label"]]];
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"cellDefault.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        NSLog(@"success!");
        cell.imageView.image = image;
//        cell.imageView.image = image;
        //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        //
        NSLog(@"fail!");
    }];
    
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
