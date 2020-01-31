#import <UIKit/UIKit.h>

@interface TUCall
@property (nonatomic,copy,readonly) NSString * displayName;
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
-(void)_loadAudioCallViewController;
-(void)updateCallControllerForCurrentState;
@end

@interface PHInCallUIUtilities
+(BOOL)isSpringBoardLocked;
@end

@interface SpringBoard <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIWindow *callWindow;
@property (strong, nonatomic) UIButton *contactView;
@property (strong, nonatomic) UIButton *acceptButton;
@property (retain, nonatomic) UIButton *declineButton;
@property (retain, nonatomic) UIButton *speakerButton;
@property (strong, nonatomic) UILabel *callerLabel;
@property (strong, nonatomic) UILabel *numberLabel;
+(id)sharedApplication;
-(void)showCallBanner;
-(void)hideCallBanner;
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

@interface SBLockScreenManager
+(id)sharedInstanceIfExists;
-(BOOL)isUILocked;
@end

%hook TUCall
-(void)_handleStatusChange {
	%orig;
	id incomingCallObject = [[%c(TUCallCenter) sharedInstance] incomingCall];

	if (incomingCallObject) {
		[[%c(SpringBoard) sharedApplication] showCallBanner];
	}
}
%end

%hook PHInCallRootViewController
-(void)_loadAudioCallViewController {
	NSLog(@"hook test phincallrootviewcontroller");
	id incomingCall = [[%c(TUCallCenter) sharedInstance] incomingCall];
	BOOL springBoardLocked = [%c(PHInCallUIUtilities) isSpringBoardLocked];
	if (incomingCall && !springBoardLocked) {
		[self prepareForDismissal];
        [self dismissPhoneRemoteViewController];

		[[%c(SpringBoard) sharedApplication] showCallBanner];
	}
}
// -(void)updateCallControllerForCurrentState {
// 	%orig;

// 	[self prepareForDismissal];
// 	[%c(PHInCallRootViewController) setShouldForceDismiss];
// 	[self dismissPhoneRemoteViewController];
// }
%end

%group MPTelephonyManagerHook
%hook MPTelephonyManager
-(void)displayAlertForCallIfNecessary:(id)arg1 {
	NSLog(@"displayAlertForCallIfNecessary hook test");
	// %orig // noop
}
-(BOOL)shouldShowAlertForCall:(id)arg1 {
	// NSLog(@"shouldShowAlertForCall hook test");
	// NSLog(@"hook test lock screen state: %d", (int)[[%c(SBLockStateAggregator) sharedInstance] lockState]);
	// //if phone is locked, display the normal call alert viewcontroller
	// if([[%c(SBLockScreenManager) sharedInstanceIfExists] isUILocked]) {
    //     return %orig;
	// 	NSLog(@"phone is locked hook test");
	// } else {
    //     return NO;
	// }
	return YES;
}
%end
%end

%hook SpringBoard
%property (strong, nonatomic) UIWindow *callWindow;
%property (strong, nonatomic) UIButton *contactView;
%property (strong, nonatomic) UIButton *acceptButton;
%property (retain, nonatomic) UIButton *declineButton;
%property (retain, nonatomic) UIButton *speakerButton;
%property (strong, nonatomic) UILabel *callerLabel;
%property (strong, nonatomic) UILabel *numberLabel;
-(void)applicationDidFinishLaunching:(UIApplication *)arg1 {
	if (!self.callWindow) {
		CGRect screenBounds = [UIScreen mainScreen].bounds;

		self.callWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, -150, screenBounds.size.width - 20, 100)];
		[self.callWindow setBackgroundColor: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6]];
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		blurEffectView.frame = self.callWindow.bounds;
		blurEffectView.layer.cornerRadius = 10;
		blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[blurEffectView.layer setMasksToBounds:YES];
		[self.callWindow addSubview:blurEffectView];

		self.callWindow.windowLevel = UIWindowLevelAlert + 10;
		self.callWindow.layer.cornerRadius = 10;
		self.callWindow.userInteractionEnabled = YES;
		self.callWindow.hidden = YES;
		[self.callWindow.layer setMasksToBounds:YES];
		[self.callWindow makeKeyAndVisible];

		static UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideCallBanner)];
		swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
		[self.callWindow addGestureRecognizer:swipeUpGesture];

		if (!self.contactView) {
			self.contactView = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
			self.contactView.alpha = 1.0;
			self.contactView.layer.cornerRadius = 10.0;
			self.contactView.backgroundColor = [UIColor whiteColor];

			[self.callWindow addSubview:self.contactView]; 
		}

		if (!self.acceptButton) {
			self.acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 55, (screenBounds.size.width - 150) / 2, 30)];
			self.acceptButton.alpha = 1.0;
			self.acceptButton.layer.cornerRadius = 10.0;
			self.acceptButton.backgroundColor = [UIColor colorWithRed:0.13 green:0.75 blue:0.42 alpha:1.0];

			UITapGestureRecognizer *tapAnswer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(answerCallButtonMessage)];
	        tapAnswer.numberOfTapsRequired = 1;
			[self.acceptButton addGestureRecognizer:tapAnswer];

			[self.callWindow addSubview:self.acceptButton];
		}

		if (!self.declineButton) {
			self.declineButton = [[UIButton alloc] initWithFrame:CGRectMake(((screenBounds.size.width - 150) / 2) + 115, 55, (screenBounds.size.width - 150) / 2, 30)];
			self.declineButton.alpha = 1.0;
			self.declineButton.layer.cornerRadius = 10.0;
			self.declineButton.backgroundColor = [UIColor redColor];

			UITapGestureRecognizer *tapHangUp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hangUpButtonMessage)];
			tapHangUp.numberOfTapsRequired = 1;
			[self.declineButton addGestureRecognizer:tapHangUp];

			[self.callWindow addSubview:self.declineButton];
		}

		if (!self.callerLabel) {
			self.callerLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, screenBounds.size.width / 2, 20)];
			self.callerLabel.font = [UIFont systemFontOfSize:20];

			[self.callWindow addSubview:self.callerLabel];
		}
		//[self showCallBanner]; //testing
		NSLog(@"here hook test");
	}
	%orig;
}
%new
-(void)showCallBanner {
	NSLog(@"showCallBanner");

	[[%c(PHInCallRootViewController) sharedInstance] prepareForDismissal];
	[[%c(PHInCallRootViewController) sharedInstance] dismissPhoneRemoteViewController];
	[[%c(PHInCallRootViewController) sharedInstance] setShouldForceDismiss];

	TUCall *incomingCallInfo = [[%c(TUCallCenter) sharedInstance] incomingCall];
	self.callerLabel.text = incomingCallInfo.displayName;

	[UIView animateWithDuration:0.3f animations:^{
		self.callWindow.hidden = NO;
		self.callWindow.alpha = 1.0;
		self.callWindow.center = CGPointMake(self.callWindow.center.x, +85);
	}
	completion:^(BOOL finished) {

	}];
}
%new
-(void)hideCallBanner {
	NSLog(@"hideCallBanner");

	[UIView animateWithDuration:0.3f animations:^{
		self.callWindow.alpha = 0.0;
		self.callWindow.center = CGPointMake(self.callWindow.center.x, -85);
	}
	completion:^(BOOL finished) {
		self.callWindow.hidden = YES;
	}];
}
%new
-(void)answerCallButtonMessage {
	[[%c(TUCallCenter) sharedInstance] answerCall:[[%c(TUCallCenter) sharedInstance] incomingCall]];
	NSLog(@"answer button tapped");
}
%new
-(void)hangUpButtonMessage {
	[[%c(TUCallCenter) sharedInstance] disconnectCall:[[%c(TUCallCenter) sharedInstance] incomingCall]];
	[self hideCallBanner];
	NSLog(@"hang up button tapped");
}
%end

%ctor {
	%init(_ungrouped);
	if ([[NSBundle bundleWithPath:@"/System/Library/SpringBoardPlugins/IncomingCall.servicebundle"] load]) {
		NSLog(@"[CallConnect] bundle loaded succesfully!");
		%init(MPTelephonyManagerHook);
	}
}
