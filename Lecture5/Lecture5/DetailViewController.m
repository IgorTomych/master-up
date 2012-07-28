//
//  DetailViewController.m
//  Lecture5
//
//  Created by Igor Tomych on 7/28/12.
//  Copyright (c) 2012 Igor Tomych. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize lblApplicationName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLblApplicationName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)loadApplicationFromDictionary:(NSDictionary *)applicationData {
    NSLog(@"loading application info to UI");
    NSLog(@"%@", applicationData);
    lblApplicationName.text = [[applicationData objectForKey:@"title"] objectForKey:@"label"];
}
- (void)dealloc {
    [lblApplicationName release];
    [super dealloc];
}
@end
