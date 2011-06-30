//
//  Timer_WorkingViewController.m
//  Timer Working
//
//  Created by Jeff Dennhardt on 6/30/11.
//  Copyright 2011 University of Illinois. All rights reserved.
//

#import "Timer_WorkingViewController.h"

@implementation Timer_WorkingViewController

@synthesize timerChooser;
@synthesize timerLabel;
@synthesize timesUp;
@synthesize startButton;
@synthesize stopButton;

int curTime = 0;
int tempTime = 0;

/**Start button that initiates cycle.
 **/
-(IBAction)start{
    
    theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showActivity) userInfo:nil repeats:YES];  
    startButton.hidden = YES;
    stopButton.hidden = NO;
    timerChooser.hidden = YES;
    timesUp.hidden = YES;
    if(curTime==0){
        curTime = timerChooser.countDownDuration+1;
        [self showActivity];
    }
    timerLabel.hidden = NO;
}

/**When the stop button is pressed, turn to the picker mode and stop counting.
 **/
-(IBAction)stop{
    [theTimer invalidate];
    timerChooser.countDownDuration = tempTime;
    startButton.hidden = NO;
    stopButton.hidden = YES;
    timerChooser.hidden = NO;
}

/**The countdown mechanism starts after the datepicker becomes hidden, decrementing in seconds.
 **/
-(void)showActivity{
    curTime = curTime - 1;
    if ( curTime < 0) {
        curTime = tempTime;
    }
    
    else if (curTime <= 0) {
        [theTimer invalidate];
        self.timerLabel.text = @"Time's up!";
        startButton.hidden = NO;
        stopButton.hidden = YES;
        timerChooser.hidden = NO;
        timerLabel.hidden = YES;
        timesUp.hidden = NO;
    }
    
    //format the seconds into a nice format
    
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    
    if (curTime < 3600) {
        minutes = curTime / 60;
        seconds = curTime % 60;
        
    }
    
    else if (curTime >= 3600) {
        hours = curTime / 3600;
        minutes = (curTime % 3600) / 60;
        seconds = curTime % 60;
    }
    
    NSString *secondString = [NSString stringWithFormat:@"%i", seconds];
    NSString *minuteString = [NSString stringWithFormat:@"%i", minutes];
    NSString *hourString = [NSString stringWithFormat:@"%i", hours];
    
    int secondStringLength = [secondString length];
    int minuteStringLength = [minuteString length];
    int hourStringLength = [hourString length];
    
    NSString *zeroString = @"0";
    
    if (secondStringLength == 1) {
        secondString = [zeroString stringByAppendingString:secondString];       
    }
    if (minuteStringLength == 1) {
        minuteString = [zeroString stringByAppendingString:minuteString];       
    }
    if (hourStringLength == 1) {
        hourString = [zeroString stringByAppendingString:hourString];   
    }
    
    timerLabel.text = [hourString stringByAppendingString:[@":"stringByAppendingString:[minuteString stringByAppendingString:[@":"stringByAppendingString:secondString ]]]];
    
    
}

- (IBAction) timerChooserChanged:(id)sender {
    curTime = timerChooser.countDownDuration+1;
    [self showActivity];
    timesUp.hidden = YES;
    timerLabel.hidden = NO;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    timerChooser.datePickerMode = UIDatePickerModeCountDownTimer;
    
    stopButton.hidden = YES;
    self.timesUp.hidden = YES;
    
    self.timerLabel.text = @"00:00:00";
    
    [timerChooser addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:timerChooser];
    [timerChooser release];
}


- (void)dealloc
{
    [timerChooser release];
    [super dealloc];
}

/**when the picker has been changed, update the value.
 **/
- (void)changeDateInLabel:(id)sender{
    int count = timerChooser.countDownDuration;
    curTime = count;
    tempTime = count;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
