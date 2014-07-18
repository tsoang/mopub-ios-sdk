//
//  Copyright (c) 2013 Tap for Tap. All rights reserved.
//

#import "TFTMoPubInterstitial.h"
#import "MPLogging.h"



@implementation TFTMoPubInterstitial
- (id) init {
    self = [super init];
    if (self) {
        [TFTTapForTap initializeWithAPIKey:@"6646e0306b4721d1fe4383dec8ded71b"];
        self.interstitial = [TFTInterstitial interstitialWithDelegate:self];
    }
    return self;
}

- (void) dealloc {
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    [self.interstitial load];
    // If Tap for Tap already has an interstitial ready let MoPub know
    if (self.interstitial.readyToShow) {
        [self.delegate interstitialCustomEvent:self didLoadAd:self];
    }
    CLLocation *location = self.delegate.location;
    if (location) {
        [TFTTapForTap setLocation:location];
    }
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [self.interstitial showWithViewController:rootViewController];
}

- (void)tftInterstitialDidReceiveAd:(TFTInterstitial *)interstitial {
    MPLogInfo(@"TapForTap Interstitial did load");
    [self.delegate interstitialCustomEvent:self didLoadAd:self];
}

- (void)tftInterstitial:(TFTInterstitial *)interstitial didFail:(NSString *)reason {
    MPLogInfo(@"TapForTap Interstitial failed to load with error: %@", reason);
    
    NSError *error = [NSError errorWithDomain:@"TapForTap" code:-1 userInfo:@{NSLocalizedDescriptionKey: reason}];
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)tftInterstitialDidShow:(TFTInterstitial *)interstitial {
    MPLogInfo(@"TapForTap Interstitial did present");
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)tftInterstitialWasTapped:(TFTInterstitial *)interstitial {
    MPLogInfo(@"TapForTap Interstitial was tapped");
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void) tftInterstitialWasDismissed:(TFTInterstitial *)interstitial {
    MPLogInfo(@"TapForTap Interstitial did dismiss");
    [self.delegate interstitialCustomEventDidDisappear:self];
}

@end
