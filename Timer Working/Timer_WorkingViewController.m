//
//  Timer_WorkingViewController.m
//  Timer Working
//
//  Created by Jeff Dennhardt on 6/30/11.
//  Copyright 2011 University of Illinois. All rights reserved.
//

#import "Timer_WorkingViewController.h"

@implementation Timer_WorkingViewController

@synthesize timerLabel;
@synthesize timesUp;

@synthesize startButton;
@synthesize pauseButton;

@synthesize timerChooser;

int curTime = 0;
int tempTime = 0;

/**Start button that initiates cycle.
 **/
-(IBAction)start{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showActivity) userInfo:nil repeats:YES];  
    timerChooser.hidden = YES;
    startButton.hidden = YES;
    pauseButton.hidden = NO;
}

/**When the stop button is pressed, turn to the picker mode and stop counting.
 **/
-(IBAction)stop{
    [timer invalidate];
    timerChooser.countDownDuration = tempTime;
    timerChooser.hidden = NO;
    startButton.hidden = NO;
    pauseButton.hidden = YES;
}

/**The countdown mechanism starts after the datepicker becomes hidden, decrementing in seconds.
 **/
-(void)showActivity{
    curTime = curTime - 1;
    if ( curTime < 0) {
        curTime = tempTime;
    }
    
    else if (curTime == 0) {
        [timer invalidate];
        startButton.hidden = NO;
        pauseButton.hidden = YES;
        timerChooser.hidden = NO;
        timerLabel.hidden = YES;
        timesUp.hidden = NO;
        timerChooser.countDownDuration = 0;
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
    
    timerLabel.text = [hourString stringByAppendingString:[@":"stringByAppendingString:[minuteString stringByAppendingString:[@":" stringByAppendingString:secondString ]]]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialization code
    timerChooser.datePickerMode = UIDatePickerModeCountDownTimer;
    timerChooser.hidden = NO;
    
    pauseButton.hidden = YES;
    timesUp.hidden = YES;
    
    self.timerLabel.text = @"00:00:00";
    
    //no need, want user to choose, default will be zero
    //datePicker.date = [NSDate date];
    [timerChooser addTarget:self
                   action:@selector(changeDateInLabel:)
         forControlEvents:UIControlEventValueChanged];
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

-(IBAction)showChosenTime:(id)sender {
	curTime = timerChooser.countDownDuration+1;
    timerLabel.hidden = NO;
    timesUp.hidden = YES;
    [self showActivity];
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
