#import <UIKit/UIKit.h>

@interface TUCall
@end

@interface PHInCallRootViewController:UIViewController
@property (retain, nonatomic) UIViewController* CallViewController;
@property (assign) BOOL dismissalWasDemandedBeforeRemoteViewControllerWasAvailable;
@property(retain, nonatomic) TUCall *alertActivationCall;
+(id)sharedInstance;
+(void)setShouldForceDismiss;
-(void)prepareForDismissal;
-(void)dismissPhoneRemoteViewController;
-(void)presentPhoneRemoteViewControllerForView:(id)arg1;
@end

@interface SpringBoard <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIWindow *callWindow;
@property (strong, nonatomic) UIButton *answerButton;
+(id)sharedApplication;
@end

@interface SBLockStateAggregator
+(id)sharedInstance;
-(unsigned long long)lockState;
@end

// call interaction
@interface TUCallCenter
+(id)sharedInstance;
-(id)incomingCall;
-(void)answerCall:(id)arg1;
-(void)disconnectCall:(id)arg1;
-(void)holdCall:(id)arg1 ;
-(void)unholdCall:(id)arg1;
@end

%hook SpringBoard
%property (strong, nonatomic) UIWindow *callWindow;
%property (strong, nonatomic) UIButton *acceptButton;
-(void)applicationDidFinishLaunching:(UIApplication *)arg1 {
	if (!self.callWindow) {
		CGRect screenBounds = [UIScreen mainScreen].bounds;

		self.callWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, 10, screenBounds.size.width - 20, 100)];
		[self.callWindow setBackgroundColor: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6]];
		[self.callWindow makeKeyAndVisible];
	}
	%orig;
}
%end