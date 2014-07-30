//
//  BIDViewController.h
//  SlowWorker
//
//  Created by Dexter Launchlabs on 7/30/14.
//  Copyright (c) 2014 Dexter Launchlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UITextView *resultsTextView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)doWork:(id)sender;
@end
