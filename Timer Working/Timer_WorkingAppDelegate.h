//
//  Timer_WorkingAppDelegate.h
//  Timer Working
//
//  Created by Jeff Dennhardt on 6/30/11.
//  Copyright 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Timer_WorkingViewController;

@interface Timer_WorkingAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Timer_WorkingViewController *viewController;

@end
