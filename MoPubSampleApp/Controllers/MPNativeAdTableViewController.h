//
//  MPNativeAdTableViewController.h
//  MoPub
//
//  Copyright (c) 2014 MoPub. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPAdInfo;

extern NSString *const kNativeAdTableViewAccessibilityLabel;

@interface MPNativeAdTableViewController : UITableViewController

- (id)initWithAdInfo:(MPAdInfo *)info;

@end
