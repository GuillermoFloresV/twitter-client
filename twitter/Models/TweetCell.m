//
//  TweetCell.m
//  
//
//  Created by gfloresv on 6/30/20.
//

#import "TweetCell.h"
#import "APIManager.h"
@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
        if(self.tweet.favorited)
        {
            NSLog(@"Unliked a tweet!");
            self.tweet.favorited = NO;
            self.tweet.favoriteCount -= 1;
            Tweet *curr_tweet = self.tweet;
            [[APIManager shared] unFavorite:curr_tweet completion:^(Tweet *tweet, NSError *error) {
                if(error)
                {
                    NSLog(@"%@", error.localizedDescription);
                }
                else{
                }
            }];
            [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
            [self refreshData];
        }
        else{
            NSLog(@"Liked a tweet!");
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            Tweet *curr_tweet = self.tweet;
            [[APIManager shared] favorite:curr_tweet completion:^(Tweet *tweet, NSError *error) {
                if(error)
                {
                    NSLog(@"%@", error.localizedDescription);
                }
                else{
                }

            }];
                        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
            [self refreshData];
        }

    }
- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted)
    {
        NSLog(@"un retweeted a tweet!");
        NSLog(@"Cannot retweet, because it is already retweeted");
        //call un retweet in future
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        Tweet *curr_tweet = self.tweet;
        [[APIManager shared] unRetweet:curr_tweet completion:^(Tweet *tweet, NSError *error) {
            if(error)
            {
                NSLog(@"%@", error.localizedDescription);
            }
            else{}
            [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
            [self refreshData];
                }];
    }
    else
    {
        NSLog(@"Retweeted a tweet!");
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        Tweet *curr_tweet = self.tweet;
        [[APIManager shared] retweet:curr_tweet completion:^(Tweet *tweet, NSError *error) {
            if(error)
            {
                NSLog(@"%@", error.localizedDescription);
            }
            else{}
            [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
            [self refreshData];
                }];
    }
}
-(void) refreshData{
    NSLog(@"Refreshing data");
    int new_fav_count = self.tweet.favoriteCount;
    int new_retweet_count = self.tweet.retweetCount;
    self.numFavoritesLabel.text = [@(new_fav_count) stringValue];
    self.numRetweetLabel.text = [@(new_retweet_count) stringValue];
}


@end
