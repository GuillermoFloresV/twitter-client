//
//  TweetCell.h
//  
//
//  Created by gfloresv on 6/30/20.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilepictureView;
@property (weak, nonatomic) IBOutlet UILabel *numRetweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFavoritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (nonatomic, strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
