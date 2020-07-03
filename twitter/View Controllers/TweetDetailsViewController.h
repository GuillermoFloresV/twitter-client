//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by gfloresv on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, strong) User *user;
@end

NS_ASSUME_NONNULL_END
