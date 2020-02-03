#line 1 "tweak.xm"
#import <UIKit/UIKit.h>
#import "MRYIPCCenter.h"

@interface TUCall
@property (nonatomic,copy,readonly) NSString * displayName;
@end

@interface SKJServer : NSObject
@property (nonatomic, strong) MRYIPCCenter *center;
@end

@implementation SKJServer


+(void)load {
	[self sharedInstance];
}


+(instancetype)sharedInstance {
	static dispatch_once_t onceToken = 0;
	__strong static SKJServer* sharedInstance = nil;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}


-(instancetype)init {
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

@class SBStatusBarManager; @class TUCall; @class PHInCallUIUtilities; @class MPTelephonyManager; @class SBInCallAlertManager; @class SpringBoard; @class TUCallCenter; 
static void (*_logos_orig$_ungrouped$SBInCallAlertManager$reactivateAlertFromStatusBarTap)(_LOGOS_SELF_TYPE_NORMAL SBInCallAlertManager* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBInCallAlertManager$reactivateAlertFromStatusBarTap(_LOGOS_SELF_TYPE_NORMAL SBInCallAlertManager* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$TUCall$_handleStatusChange)(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TUCall$_handleStatusChange(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static BOOL _logos_method$_ungrouped$SpringBoard$isSpringBoardLocked(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$showCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$hideCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$answerCallButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$hangUpButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$setDisplayName$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, NSString *); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBStatusBarManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBStatusBarManager"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$PHInCallUIUtilities(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("PHInCallUIUtilities"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SpringBoard(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SpringBoard"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$TUCallCenter(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("TUCallCenter"); } return _klass; }
#line 93 "tweak.xm"

static void _logos_method$_ungrouped$SBInCallAlertManager$reactivateAlertFromStatusBarTap(_LOGOS_SELF_TYPE_NORMAL SBInCallAlertManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"reactivateAlertFromStatusBarTap hook test: %@", [NSProcessInfo processInfo].processName);
	SpringBoard *springboard = (SpringBoard*)[NSClassFromString(@"SpringBoard") sharedApplication];
	if (springboard.isCallHudHidden) {
		[springboard showCallBanner];
	}
	NSLog(@"%@", springboard);
}



static void _logos_method$_ungrouped$TUCall$_handleStatusChange(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$TUCall$_handleStatusChange(self, _cmd);
	NSLog(@"_handleStatusChange hook test: %@", [NSProcessInfo processInfo].processName);
	TUCall *incomingCallObject = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];

	if (incomingCallObject) {
		[[_logos_static_class_lookup$SpringBoard() sharedApplication] setDisplayName:incomingCallObject.displayName];
		[[_logos_static_class_lookup$SpringBoard() sharedApplication] showCallBanner];
	}
}


@interface UIStatusBar_Base
-(CGRect)currentFrame;
@end

@interface UIStatusBar : UIStatusBar_Base
@end

@interface SBStatusBarContainer
-(UIStatusBar *)statusBar;
@end

@class UIStatusBar;


__attribute__((used)) static UIWindow * _logos_method$_ungrouped$SpringBoard$callWindow(SpringBoard * __unused self, SEL __unused _cmd) { return (UIWindow *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallWindow(SpringBoard * __unused self, SEL __unused _cmd, UIWindow * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$contactView(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$contactView); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setContactView(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$contactView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$acceptButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setAcceptButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$declineButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$declineButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setDeclineButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$declineButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$speakerButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$speakerButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setSpeakerButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$speakerButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SpringBoard$callerLabel(SpringBoard * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callerLabel); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallerLabel(SpringBoard * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callerLabel, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SpringBoard$numberLabel(SpringBoard * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$numberLabel); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setNumberLabel(SpringBoard * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$numberLabel, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static BOOL _logos_method$_ungrouped$SpringBoard$isCallHudHidden(SpringBoard * __unused self, SEL __unused _cmd) { NSValue * value = objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$isCallHudHidden); BOOL rawValue; [value getValue:&rawValue]; return rawValue; }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setIsCallHudHidden(SpringBoard * __unused self, SEL __unused _cmd, BOOL rawValue) { NSValue * value = [NSValue valueWithBytes:&rawValue objCType:@encode(BOOL)]; objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$isCallHudHidden, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static SKJServer * _logos_method$_ungrouped$SpringBoard$server(SpringBoard * __unused self, SEL __unused _cmd) { return (SKJServer *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$server); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setServer(SpringBoard * __unused self, SEL __unused _cmd, SKJServer * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$server, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIApplication * arg1) {
	if (!self.server) {
		[SKJServer load];
		[self.server.center registerMethod:@selector(showCallBanner:) withTarget:self];
		[self.server.center registerMethod:@selector(hideCallBanner:) withTarget:self];
		[self.server.center registerMethod:@selector(isSpringBoardLocked:) withTarget:self];
	}
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

static BOOL _logos_method$_ungrouped$SpringBoard$isSpringBoardLocked(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return [_logos_static_class_lookup$PHInCallUIUtilities() isSpringBoardLocked];
}

static void _logos_method$_ungrouped$SpringBoard$showCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"showCallBanner");
	self.isCallHudHidden = NO;
	NSLog(@"hook test status bar: %f", [((SBStatusBarContainer *)[MSHookIvar<NSHashTable *>((SBStatusBarManager *)[_logos_static_class_lookup$SBStatusBarManager() sharedInstance], "_statusBars") anyObject]).statusBar currentFrame].size.height);
	NSLog(@"hook test root view controller: %@", MSHookIvar<SBUIController *>(self, "_uiController"));


	
	
	
	
	
	
	
	

	[UIView animateWithDuration:0.3f animations:^{
		self.callWindow.hidden = NO;
		self.callWindow.alpha = 1.0;
		self.callWindow.center = CGPointMake(self.callWindow.center.x, ([((SBStatusBarContainer *)[MSHookIvar<NSHashTable *>((SBStatusBarManager *)[_logos_static_class_lookup$SBStatusBarManager() sharedInstance], "_statusBars") anyObject]).statusBar currentFrame].size.height) + 45);
	}
	completion:^(BOOL finished) {
	}];
}

static void _logos_method$_ungrouped$SpringBoard$hideCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
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

static void _logos_method$_ungrouped$SpringBoard$answerCallButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[_logos_static_class_lookup$TUCallCenter() sharedInstance] answerCall:[[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall]];
	NSLog(@"answer button tapped");
}

static void _logos_method$_ungrouped$SpringBoard$hangUpButtonMessage(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	
	[[_logos_static_class_lookup$TUCallCenter() sharedInstance] disconnectAllCalls];
	[self hideCallBanner];
	NSLog(@"hang up button tapped");
}

static void _logos_method$_ungrouped$SpringBoard$setDisplayName$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * inputName) {
	self.callerLabel.text = inputName;
}


static void (*_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$)(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$)(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST, SEL, id); 

static void _logos_method$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	NSLog(@"displayAlertForCallIfNecessary hook test: %@", [NSProcessInfo processInfo].processName);
	
}
static BOOL _logos_method$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$(_LOGOS_SELF_TYPE_NORMAL MPTelephonyManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	NSLog(@"shouldShowAlertForCall hook test: %@", [NSProcessInfo processInfo].processName);
	
	
	
    
	
	
    
	
	return YES;
}



static __attribute__((constructor)) void _logosLocalCtor_92845753(int __unused argc, char __unused **argv, char __unused **envp) {
	{Class _logos_class$_ungrouped$SBInCallAlertManager = objc_getClass("SBInCallAlertManager"); MSHookMessageEx(_logos_class$_ungrouped$SBInCallAlertManager, @selector(reactivateAlertFromStatusBarTap), (IMP)&_logos_method$_ungrouped$SBInCallAlertManager$reactivateAlertFromStatusBarTap, (IMP*)&_logos_orig$_ungrouped$SBInCallAlertManager$reactivateAlertFromStatusBarTap);Class _logos_class$_ungrouped$TUCall = objc_getClass("TUCall"); MSHookMessageEx(_logos_class$_ungrouped$TUCall, @selector(_handleStatusChange), (IMP)&_logos_method$_ungrouped$TUCall$_handleStatusChange, (IMP*)&_logos_orig$_ungrouped$TUCall$_handleStatusChange);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(isSpringBoardLocked), (IMP)&_logos_method$_ungrouped$SpringBoard$isSpringBoardLocked, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(showCallBanner), (IMP)&_logos_method$_ungrouped$SpringBoard$showCallBanner, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(hideCallBanner), (IMP)&_logos_method$_ungrouped$SpringBoard$hideCallBanner, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(answerCallButtonMessage), (IMP)&_logos_method$_ungrouped$SpringBoard$answerCallButtonMessage, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(hangUpButtonMessage), (IMP)&_logos_method$_ungrouped$SpringBoard$hangUpButtonMessage, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setDisplayName:), (IMP)&_logos_method$_ungrouped$SpringBoard$setDisplayName$, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callWindow), (IMP)&_logos_method$_ungrouped$SpringBoard$callWindow, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallWindow:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallWindow, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(contactView), (IMP)&_logos_method$_ungrouped$SpringBoard$contactView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setContactView:), (IMP)&_logos_method$_ungrouped$SpringBoard$setContactView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(acceptButton), (IMP)&_logos_method$_ungrouped$SpringBoard$acceptButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setAcceptButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setAcceptButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(declineButton), (IMP)&_logos_method$_ungrouped$SpringBoard$declineButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setDeclineButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setDeclineButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(speakerButton), (IMP)&_logos_method$_ungrouped$SpringBoard$speakerButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setSpeakerButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setSpeakerButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callerLabel), (IMP)&_logos_method$_ungrouped$SpringBoard$callerLabel, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallerLabel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallerLabel, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(numberLabel), (IMP)&_logos_method$_ungrouped$SpringBoard$numberLabel, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setNumberLabel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setNumberLabel, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(BOOL)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(isCallHudHidden), (IMP)&_logos_method$_ungrouped$SpringBoard$isCallHudHidden, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(BOOL)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setIsCallHudHidden:), (IMP)&_logos_method$_ungrouped$SpringBoard$setIsCallHudHidden, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(SKJServer *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(server), (IMP)&_logos_method$_ungrouped$SpringBoard$server, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(SKJServer *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setServer:), (IMP)&_logos_method$_ungrouped$SpringBoard$setServer, _typeEncoding); } }
	if ([[NSBundle bundleWithPath:@"/System/Library/SpringBoardPlugins/IncomingCall.servicebundle"] load]) {
		NSLog(@"[CallConnect] bundle loaded succesfully! hook test");
		{Class _logos_class$MPTelephonyManagerHook$MPTelephonyManager = objc_getClass("MPTelephonyManager"); MSHookMessageEx(_logos_class$MPTelephonyManagerHook$MPTelephonyManager, @selector(displayAlertForCallIfNecessary:), (IMP)&_logos_method$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$, (IMP*)&_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$displayAlertForCallIfNecessary$);MSHookMessageEx(_logos_class$MPTelephonyManagerHook$MPTelephonyManager, @selector(shouldShowAlertForCall:), (IMP)&_logos_method$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$, (IMP*)&_logos_orig$MPTelephonyManagerHook$MPTelephonyManager$shouldShowAlertForCall$);}
	}
}
