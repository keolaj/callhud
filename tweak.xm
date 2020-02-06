#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import <UIKit/UIWindow+Private.h>
#import "MRYIPCCenter.h"

@interface TUCall
@property (nonatomic,copy,readonly) NSString * displayName;
@property (nonatomic,copy,readonly) NSString * contactIdentifier; 
@end

@interface SKJServer : NSObject
@property (nonatomic, strong) MRYIPCCenter *center;
@end

@implementation SKJServer

+(void)load
{
	[self sharedInstance];
}

+(instancetype)sharedInstance
{
	static dispatch_once_t onceToken = 0;
	__strong static SKJServer* sharedInstance = nil;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

-(instancetype)init
{
	if ((self = [super init]))
	{
		self.center = [MRYIPCCenter centerNamed:@"com.keolajarvegren.SKJServer"];
		NSLog(@"[SKJServer] running server in %@", [NSProcessInfo processInfo].processName);
	}
	return self;
}
@end

@interface SpringBoard <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIWindow *callWindow;
@property (strong, nonatomic) UIButton *contactView;
@property (strong, nonatomic) UIButton *acceptButton;
@property (retain, nonatomic) UIButton *declineButton;
@property (retain, nonatomic) UIButton *speakerButton;
@property (strong, nonatomic) UILabel *callerLabel;
@property (strong, nonatomic) UILabel *numberLabel;
@property (nonatomic) BOOL isCallHudHidden;
@property (strong, nonatomic) SKJServer *server;
+(id)sharedApplication;
-(void)showCallBanner;
-(void)hideCallBanner;
-(BOOL)isSpringBoardLocked;
-(void)setDisplayName:(NSString*)inputString;
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
-(void)disconnectAllCalls;
@end

@interface SBLockScreenManager
+(id)sharedInstanceIfExists;
-(BOOL)isUILocked;
@end

@interface MPTelephonyManager
-(void)displayAlertForCallIfNecessary:(id)arg1;
-(BOOL)shouldShowAlertForCall:(id)arg1;
@end

@interface SBInCallAlertManager
-(void)reactivateAlertFromStatusBarTap;
@end

@interface SBStatusBarManager
+(id)sharedInstance;
@end

@class SBUIController;

%hook SBInCallAlertManager
-(void)reactivateAlertFromStatusBarTap {
	NSLog(@"reactivateAlertFromStatusBarTap hook test: %@", [NSProcessInfo processInfo].processName);
	SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
	if (springboard.isCallHudHidden) {
		[springboard showCallBanner];
	}
	NSLog(@"%@", springboard);
}
%end

%hook TUCall
-(void)_handleStatusChange {
	%orig;
	NSLog(@"_handleStatusChange hook test: %@", [NSProcessInfo processInfo].processName);
	TUCall *incomingCallObject = [[%c(TUCallCenter) sharedInstance] incomingCall];

	if (incomingCallObject) {
		SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
		[springboard setDisplayName:incomingCallObject.displayName];

		CNContactStore *store = [[%c(CNContactStore) alloc] init];
		NSError *error;
		CNContact *currentCallContact = [store unifiedContactWithIdentifier:(((TUCall *)[[%c(TUCallCenter) sharedInstance] incomingCall]).contactIdentifier) keysToFetch:@[CNContactGivenNameKey, CNContactThumbnailImageDataKey] error:&error];
		// if (currentCallContact.thumbnailImageData) {
		// 	UIImage *contactImage = [UIImage imageWithData:currentCallContact.thumbnailImageData];
		// } else  {
		
		// }
		UIImage *contactImage = [UIImage imageWithData:currentCallContact.thumbnailImageData];
		NSLog(@"hook test image data: %@", contactImage);

		[springboard.contactView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
		

		UIImageView *contactImageView = [[UIImageView alloc] initWithImage:contactImage];
		contactImageView.frame = springboard.contactView.bounds;
		contactImageView.layer.cornerRadius = 35;
		contactImageView.clipsToBounds = YES;
		[springboard.contactView addSubview:contactImageView];

		[springboard showCallBanner];
	}
}
%end

@interface UIStatusBar_Base
-(CGRect)currentFrame;
@end

@interface UIStatusBar : UIStatusBar_Base
@end

@interface SBStatusBarContainer
-(UIStatusBar *)statusBar;
@end

@class UIStatusBar;

%hook SpringBoard
%property (strong, nonatomic) UIWindow *callWindow;
%property (strong, nonatomic) UIButton *contactView;
%property (strong, nonatomic) UIButton *acceptButton;
%property (retain, nonatomic) UIButton *declineButton;
%property (retain, nonatomic) UIButton *speakerButton;
%property (strong, nonatomic) UILabel *callerLabel;
%property (strong, nonatomic) UILabel *numberLabel;
%property (assign, nonatomic) BOOL isCallHudHidden;
%property (strong, nonatomic) SKJServer *server;
-(void)applicationDidFinishLaunching:(UIApplication *)arg1 {
	if (!self.server) {
		[SKJServer load];
		[self.server.center registerMethod:@selector(showCallBanner:) withTarget:self];
		[self.server.center registerMethod:@selector(hideCallBanner:) withTarget:self];
		[self.server.center registerMethod:@selector(isSpringBoardLocked:) withTarget:self];
	}
	if (!self.callWindow) {
		CGRect screenBounds = [UIScreen mainScreen].bounds;
		self.callWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, -150, screenBounds.size.width - 20, 100)];
		[self.callWindow _setSecure:YES];
		[self.callWindow setBackgroundColor: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6]];
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		blurEffectView.frame = self.callWindow.bounds;
		blurEffectView.layer.cornerRadius = 10;
		blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[blurEffectView.layer setMasksToBounds:YES];
		[self.callWindow addSubview:blurEffectView];
		self.isCallHudHidden = YES;

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
			self.contactView.layer.cornerRadius = self.contactView.frame.size.width / 2;
			self.contactView.clipsToBounds = YES;

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
-(BOOL)isSpringBoardLocked {
	return [%c(PHInCallUIUtilities) isSpringBoardLocked];
}
%new
-(void)showCallBanner {
	//NSLog(@"showCallBanner");
	self.isCallHudHidden = NO;
	//NSLog(@"hook test status bar: %f", [((SBStatusBarContainer *)[MSHookIvar<NSHashTable *>((SBStatusBarManager *)[%c(SBStatusBarManager) sharedInstance], "_statusBars") anyObject]).statusBar currentFrame].size.height);
	//NSLog(@"hook test root view controller: %@", MSHookIvar<SBUIController *>(self, "_uiController"));
	//NSLog(@"hook test contact identifier: %@", ((TUCall *)[[%c(TUCallCenter) sharedInstance] incomingCall]).contactIdentifier);
	//NSLog(@"hook test CNContactStore authorization value: %ld", [CNContactStore authorizationStatusForEntityType:entityType]);
	

	// [[%c(PHInCallRootViewController) sharedInstance] prepareForDismissal];
	// [[%c(PHInCallRootViewController) sharedInstance] dismissPhoneRemoteViewController];
	// [[%c(PHInCallRootViewController) sharedInstance] setShouldForceDismiss];

	NSLog(@"hook test current status bar height: %f", ([((SBStatusBarContainer *)[MSHookIvar<NSHashTable *>((SBStatusBarManager *)[%c(SBStatusBarManager) sharedInstance], "_statusBars") anyObject]).statusBar currentFrame].size.height));

	[UIView animateWithDuration:0.3f animations:^{
		self.callWindow.hidden = NO;
		self.callWindow.alpha = 1.0;
		self.callWindow.center = CGPointMake(self.callWindow.center.x, [UIApplication sharedApplication].statusBarFrame.size.height + 50);
		// ([((SBStatusBarContainer *)[MSHookIvar<NSHashTable *>((SBStatusBarManager *)[%c(SBStatusBarManager) sharedInstance], "_statusBars") anyObject]).statusBar currentFrame].size.height) + 50
	}
	completion:^(BOOL finished) {
	}];
}
%new
-(void)hideCallBanner {
	NSLog(@"hideCallBanner");
	NSLog(@"hook test %@", self.callerLabel.text);
	self.isCallHudHidden = YES;

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
	//[[%c(TUCallCenter) sharedInstance] disconnectCall:[[%c(TUCallCenter) sharedInstance] incomingCall]];
	[[%c(TUCallCenter) sharedInstance] disconnectAllCalls];
	[self hideCallBanner];
	NSLog(@"hang up button tapped");
}
%new
-(void)setDisplayName:(NSString *)inputName {
	self.callerLabel.text = inputName;
}
%end

%group MPTelephonyManagerHook
%hook MPTelephonyManager
-(void)displayAlertForCallIfNecessary:(id)arg1 {
	NSLog(@"displayAlertForCallIfNecessary hook test: %@", [NSProcessInfo processInfo].processName);
	//%orig; // noop
}
-(BOOL)shouldShowAlertForCall:(id)arg1 {
	NSLog(@"shouldShowAlertForCall hook test: %@", [NSProcessInfo processInfo].processName);
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

%ctor {
	%init(_ungrouped);
	if ([[NSBundle bundleWithPath:@"/System/Library/SpringBoardPlugins/IncomingCall.servicebundle"] load]) {
		NSLog(@"[CallConnect] bundle loaded succesfully! hook test");
		%init(MPTelephonyManagerHook);
	}
}