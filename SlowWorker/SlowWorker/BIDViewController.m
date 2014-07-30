//
//  BIDViewController.m
//  SlowWorker
//
//  Created by Dexter Launchlabs on 7/30/14.
//  Copyright (c) 2014 Dexter Launchlabs. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()

@end

@implementation BIDViewController

@synthesize startButton, resultsTextView;
@synthesize spinner;

- (NSString *)fetchSomethingFromServer { [NSThread sleepForTimeInterval:1]; return @"Hi there";
}
- (NSString *)processData:(NSString *)data { [NSThread sleepForTimeInterval:2]; return [data uppercaseString];
}
- (NSString *)calculateFirstResult:(NSString *)data { [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"Number of chars: %d",
            [data length]];
}
- (NSString *)calculateSecondResult:(NSString *)data { [NSThread sleepForTimeInterval:4];
    return [data stringByReplacingOccurrencesOfString:@"E"
                                           withString:@"e"];
}
- (IBAction)doWork:(id)sender {
    startButton.enabled = NO;
    startButton.alpha = 0.5;
    [spinner startAnimating];
    NSDate *startTime = [NSDate date];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSString *fetchedData = [self fetchSomethingFromServer];
    NSString *processedData = [self processData:fetchedData];
 //   NSString *firstResult = [self calculateFirstResult:processedData]; NSString *secondResult = [self calculateSecondResult:processedData];
        __block NSString *firstResult;
        __block NSString *secondResult;
        dispatch_group_t group = dispatch_group_create(); dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            firstResult = [self calculateFirstResult:processedData]; });
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{ secondResult = [self calculateSecondResult:processedData];
        });
        dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
    NSString *resultsSummary = [NSString stringWithFormat:
                                @"First: [%@]\nSecond: [%@]", firstResult,
                                secondResult];
        dispatch_async(dispatch_get_main_queue(), ^{
            startButton.enabled = YES; startButton.alpha = 1.0;
            [spinner stopAnimating];
        resultsTextView.text = resultsSummary;
            });
    NSDate *endTime = [NSDate date]; NSLog(@"Completed in %f seconds",
                                           [endTime timeIntervalSinceDate:startTime]);
        });
         });
}
- (void)viewDidUnload {
    [self viewDidUnload];
    // Release any retained subviews of the main view. // e.g. self.myOutlet = nil;
    self.startButton = nil;
    self.resultsTextView = nil;
    self.spinner = nil;
}
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
