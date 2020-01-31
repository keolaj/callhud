#line 1 "tweak.xm"
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class PHInCallUIUtilities; @class TUCallCenter; @class MPTelephonyManager; @class PHInCallRootViewController; @class TUCall; @class SpringBoard; 
static void (*_logos_orig$_ungrouped$TUCall$_handleStatusChange)(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TUCall$_handleStatusChange(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController)(_LOGOS_SELF_TYPE_NORMAL PHInCallRootViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController(_LOGOS_SELF_TYPE_NORMAL PHInCallRootViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$showCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$hideCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$answerCallButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$hangUpButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$TUCallCenter(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("TUCallCenter"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$PHInCallUIUtilities(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("PHInCallUIUtilities"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SpringBoard(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SpringBoard"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$PHInCallRootViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("PHInCallRootViewController"); } return _klass; }
#line 57 "tweak.xm"

static void _logos_method$_ungrouped$TUCall$_handleStatusChange(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$TUCall$_handleStatusChange(self, _cmd);
	id incomingCallObject = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];

	if (incomingCallObject) {
		[[_logos_static_class_lookup$SpringBoard() sharedApplication] showCallBanner];
	}
}



static void _logos_method$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController(_LOGOS_SELF_TYPE_NORMAL PHInCallRootViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"hook test phincallrootviewcontroller");
	id incomingCall = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];
	BOOL springBoardLocked = [_logos_static_class_lookup$PHInCallUIUtilities() isSpringBoardLocked];
	if (incomingCall && !springBoardLocked) {
		[self prepareForDismissal];
        [self dismissPhoneRemoteViewController];

		[[_logos_static_class_lookup$SpringBoard() sharedApplication] showCallBanner];
	}
}









static void (*_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$)(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$)(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); 

static void _logos_method$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	NSLog(@"displayAleryForCallIfNecessary hook test");
	
}
static BOOL _logos_method$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	
	
	
	
    
	
	
    
	
	return YES;
}




__attribute__((used)) static UIWindow * _logos_method$_ungrouped$SpringBoard$callWindow(SpringBoard * __unused self, SEL __unused _cmd) { return (UIWindow *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallWindow(SpringBoard * __unused self, SEL __unused _cmd, UIWindow * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$contactView(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$contactView); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setContactView(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$contactView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$acceptButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setAcceptButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$declineButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$declineButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setDeclineButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$declineButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$speakerButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$speakerButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setSpeakerButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$speakerButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SpringBoard$callerLabel(SpringBoard * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callerLabel); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallerLabel(SpringBoard * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callerLabel, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SpringBoard$numberLabel(SpringBoard * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$numberLabel); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setNumberLabel(SpringBoard * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$numberLabel, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIApplication * arg1) {
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
		
		NSLog(@"here hook test");
	}
	_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$(self, _cmd, arg1);
}

static void _logos_method$_ungrouped$SpringBoard$showCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"showCallBanner");

	[[_logos_static_class_lookup$PHInCallRootViewController() sharedInstance] prepareForDismissal];
	[[_logos_static_class_lookup$PHInCallRootViewController() sharedInstance] dismissPhoneRemoteViewController];
	[[_logos_static_class_lookup$PHInCallRootViewController() sharedInstance] setShouldForceDismiss];

	TUCall *incomingCallInfo = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];
	self.callerLabel.text = incomingCallInfo.displayName;

	[UIView animateWithDuration:0.3f animations:^{
		self.callWindow.hidden = NO;
		self.callWindow.alpha = 1.0;
		self.callWindow.center = CGPointMake(self.callWindow.center.x, +85);
	}
	completion:^(BOOL finished) {

	}];
}

static void _logos_method$_ungrouped$SpringBoard$hideCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"hideCallBanner");

	[UIView animateWithDuration:0.3f animations:^{
		self.callWindow.alpha = 0.0;
		self.callWindow.center = CGPointMake(self.callWindow.center.x, -85);
	}
	completion:^(BOOL finished) {
		self.callWindow.hidden = YES;
	}];
}

static void _logos_method$_ungrouped$SpringBoard$answerCallButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[_logos_static_class_lookup$TUCallCenter() sharedInstance] answerCall:[[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall]];
	NSLog(@"answer button tapped");
}

static void _logos_method$_ungrouped$SpringBoard$hangUpButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[_logos_static_class_lookup$TUCallCenter() sharedInstance] disconnectCall:[[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall]];
	[self hideCallBanner];
	NSLog(@"hang up button tapped");
}


static __attribute__((constructor)) void _logosLocalCtor_de011b60(int __unused argc, char __unused **argv, char __unused **envp) {
	{Class _logos_class$_ungrouped$TUCall = objc_getClass("TUCall"); MSHookMessageEx(_logos_class$_ungrouped$TUCall, @selector(_handleStatusChange), (IMP)&_logos_method$_ungrouped$TUCall$_handleStatusChange, (IMP*)&_logos_orig$_ungrouped$TUCall$_handleStatusChange);Class _logos_class$_ungrouped$PHInCallRootViewController = objc_getClass("PHInCallRootViewController"); MSHookMessageEx(_logos_class$_ungrouped$PHInCallRootViewController, @selector(_loadAudioCallViewController), (IMP)&_logos_method$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController, (IMP*)&_logos_orig$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(showCallBanner), (IMP)&_logos_method$_ungrouped$SpringBoard$showCallBanner, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(hideCallBanner), (IMP)&_logos_method$_ungrouped$SpringBoard$hideCallBanner, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(answerCallButtonMessage), (IMP)&_logos_method$_ungrouped$SpringBoard$answerCallButtonMessage, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(hangUpButtonMessage), (IMP)&_logos_method$_ungrouped$SpringBoard$hangUpButtonMessage, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callWindow), (IMP)&_logos_method$_ungrouped$SpringBoard$callWindow, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallWindow:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallWindow, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(contactView), (IMP)&_logos_method$_ungrouped$SpringBoard$contactView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setContactView:), (IMP)&_logos_method$_ungrouped$SpringBoard$setContactView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(acceptButton), (IMP)&_logos_method$_ungrouped$SpringBoard$acceptButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setAcceptButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setAcceptButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(declineButton), (IMP)&_logos_method$_ungrouped$SpringBoard$declineButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setDeclineButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setDeclineButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(speakerButton), (IMP)&_logos_method$_ungrouped$SpringBoard$speakerButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setSpeakerButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setSpeakerButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callerLabel), (IMP)&_logos_method$_ungrouped$SpringBoard$callerLabel, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallerLabel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallerLabel, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(numberLabel), (IMP)&_logos_method$_ungrouped$SpringBoard$numberLabel, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setNumberLabel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setNumberLabel, _typeEncoding); } }
	if ([[NSBundle bundleWithPath:@"/System/Library/SpringBoardPlugins/IncomingCall.servicebundle"] load]) {
		NSLog(@"[CallConnect] bundle loaded succesfully!");
		{Class _logos_class$MPTelephonyManagerHook$MPTelephonyManager = objc_getClass("MPTelephonyManager"); MSHookMessageEx(_logos_class$MPTelephonyManagerHook$MPTelephonyManager, @selector(displayAlertForCallIfNecessary:), (IMP)&_logos_method$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$, (IMP*)&_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$);MSHookMessageEx(_logos_class$MPTelephonyManagerHook$MPTelephonyManager, @selector(shouldShowAlertForCall:), (IMP)&_logos_method$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$, (IMP*)&_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$);}
	}
}
