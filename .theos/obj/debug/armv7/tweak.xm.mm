#line 1 "tweak.xm"
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


@interface TUCallCenter
+(id)sharedInstance;
-(id)incomingCall;
-(void)answerCall:(id)arg1;
-(void)disconnectCall:(id)arg1;
-(void)holdCall:(id)arg1 ;
-(void)unholdCall:(id)arg1;
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

@class SpringBoard; 
static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); 

#line 38 "tweak.xm"

__attribute__((used)) static UIWindow * _logos_method$_ungrouped$SpringBoard$callWindow(SpringBoard * __unused self, SEL __unused _cmd) { return (UIWindow *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallWindow(SpringBoard * __unused self, SEL __unused _cmd, UIWindow * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$acceptButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setAcceptButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIApplication * arg1) {
	if (!self.callWindow) {
		CGRect screenBounds = [UIScreen mainScreen].bounds;

		self.callWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, 10, screenBounds.size.width - 20, 100)];
		[self.callWindow setBackgroundColor: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6]];
		[self.callWindow makeKeyAndVisible];
	}
	_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$(self, _cmd, arg1);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$);{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callWindow), (IMP)&_logos_method$_ungrouped$SpringBoard$callWindow, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallWindow:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallWindow, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(acceptButton), (IMP)&_logos_method$_ungrouped$SpringBoard$acceptButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setAcceptButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setAcceptButton, _typeEncoding); } } }
#line 52 "tweak.xm"
