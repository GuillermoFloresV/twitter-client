//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by gfloresv on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;


@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.tweet.favorited)
    {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    if(self.tweet.retweeted)
    {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    
    
    // Do any additional setup after loading the view.
    self.tweetLabel.text = _tweet.text;
    NSString *concatenatedStringAgo = [_tweet.createdAtString stringByAppendingString:@" ago" ];
    self.dateLabel.text = _tweet.createdAtDate;
    self.timeLabel.text = concatenatedStringAgo;
    //gets nums of retweets and likes for NSString conversion
    int numFavorite =self.tweet.favoriteCount;
    int numRetweet = self.tweet.retweetCount;
    
    self.retweetLabel.text =[@(numRetweet) stringValue];
    self.favoriteLabel.text = [@(numFavorite) stringValue];
    self.nameLabel.text = self.tweet.user.name;
    NSString *concatenatedString = [@"@" stringByAppendingString:self.tweet.user.screenName ];
    concatenatedString = [concatenatedString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    self.screenNameLabel.text = concatenatedString;
    
    NSURL *profileImageURLPath = [NSURL URLWithString:_tweet.user.profileImagePath];
    [self.profilePictureView setImageWithURL:profileImageURLPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)favoriteAction:(id)sender {
    
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
- (IBAction)retweetAction:(id)sender {
        if(self.tweet.retweeted)
        {
            NSLog(@"un retweeted a tweet!");
            self.tweet.retweeted = NO;
            self.tweet.retweetCount -= 1;
            Tweet *curr_tweet = self.tweet;
            [[APIManager shared] unRetweet:curr_tweet completion:^(Tweet *tweet, NSError *error) {
                if(error)
                {
                    NSLog(@"%@", error.localizedDescription);
                }
                else{
                }

            }];
            [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
            [self refreshData];
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
                else{
                }

            }];
                [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];

            [self refreshData];
        }

    }
-(void) refreshData{
    NSLog(@"Refreshing data");
    int new_fav_count = self.tweet.favoriteCount;
    int new_retweet_count = self.tweet.retweetCount;
    self.favoriteLabel.text = [@(new_fav_count) stringValue];
    self.retweetLabel.text = [@(new_retweet_count) stringValue];
}


@end
