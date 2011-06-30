//
//  Timer_WorkingViewController.h
//  Timer Working
//
//  Created by Jeff Dennhardt on 6/30/11.
//  Copyright 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Timer_WorkingViewController : UIViewController {
    IBOutlet UILabel *timerLabel;
    IBOutlet UILabel *timesUp;

    NSTimer *theTimer;
    
    IBOutlet UIDatePicker *timerChooser;
    
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *stopButton;
}

@property (nonatomic, retain) UILabel *timerLabel;
@property (nonatomic, retain) UILabel *timesUp;

@property (nonatomic, retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *stopButton;
@property (nonatomic, retain) UIDatePicker *timerChooser;

-(IBAction)start;
-(IBAction)stop;

-(void)showActivity;

- (IBAction) timerChooserChanged:(id)sender;


@end
