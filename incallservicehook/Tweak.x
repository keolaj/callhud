#import "../MRYIPCCenter.h"

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

@interface TUCallCenter
+(id)sharedInstance;
-(id)incomingCall;
-(void)answerCall:(id)arg1;
-(void)disconnectCall:(id)arg1;
-(void)holdCall:(id)arg1 ;
-(void)unholdCall:(id)arg1;
@end

%hook PHInCallRootViewController
-(void)_loadAudioCallViewController {
	NSLog(@"hook test _loadAudioViewController: %@", [NSProcessInfo processInfo].processName);
	MRYIPCCenter* center = [MRYIPCCenter centerNamed:@"com.keolajarvegren.SKJServer"];
	id incomingCall = [[%c(TUCallCenter) sharedInstance] incomingCall];
	BOOL springBoardLocked = [center callExternalMethod:@selector(isSpringBoardLocked) withArguments:nil];
	if (incomingCall && !springBoardLocked) {
		[self prepareForDismissal];
        [self dismissPhoneRemoteViewController];

		[center callExternalVoidMethod:@selector(showCallBanner) withArguments:nil];
	}
}
-(void)updateCallControllerForCurrentState {
	%orig;
	NSLog(@"hook test updateCallControllerForCurrentState: %@", [NSProcessInfo processInfo].processName);
	// [self prepareForDismissal];
	// [%c(PHInCallRootViewController) setShouldForceDismiss];
	// [self dismissPhoneRemoteViewController];
}
%end

