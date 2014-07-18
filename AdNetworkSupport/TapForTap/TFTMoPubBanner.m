//
//  Copyright (c) 2013 Tap for Tap. All rights reserved.
//

#import "TFTMoPubBanner.h"
#import "MPLogging.h"



@implementation TFTMoPubBanner

-(id) init {
    self = [super init];
    if (self) {
        [TFTTapForTap initializeWithAPIKey:@"6646e0306b4721d1fe4383dec8ded71b"];
    }
    return self;
}

-(void) dealloc {
}

-(void) requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    self.banner = [TFTBanner bannerWithFrame:[self frameForCustomEventInfo:info] delegate:self];
    self.banner.forceLoad = YES;
    self.banner.autoRollover = NO;
    
    CLLocation *location = self.delegate.location;
    if (location) {
        [TFTTapForTap setLocation:location];
    }
}

- (CGRect)frameForCustomEventInfo:(NSDictionary *)info
{
    CGFloat width = [[info objectForKey:@"adWidth"] floatValue];
    CGFloat height = [[info objectForKey:@"adHeight"] floatValue];
    
    if (width < 320 && height < 50) {
        width = 320;
        height = 50;
    }
    return CGRectMake(0, 0, width, height);
}

-(void) tftBannerDidReceiveAd:(TFTBanner *)banner {
    MPLogInfo(@"TapForTap banner did load");
    // Must user self.banner as in 3.0.2 the banner returned is nil. Will be fix in next release.
    [self.delegate bannerCustomEvent:self didLoadAd:self.banner];
}

-(void) tftBanner:(TFTBanner *)banner didFailToReceiveAd:(NSString *)reason {
    MPLogInfo(@"TapForTap banner failed to load with error: %@", reason);
    
    NSError *error = [NSError errorWithDomain:@"TapForTap" code:-1 userInfo:@{NSLocalizedDescriptionKey: reason}];
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

-(void) tftBannerWasTapped:(TFTBanner *)banner {
    MPLogInfo(@"TapForTap banner was tapped");
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

@end
