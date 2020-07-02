//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "User.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NSDate+DateTools.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;
@property (nonatomic, strong) NSMutableArray *tweetArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tweetTableView.dataSource = self;
    self.tweetTableView.delegate = self;

    //allows refreshing of home timeline
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tweetTableView insertSubview:self.refreshControl atIndex:0];
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweetArray = (NSMutableArray *) tweets;
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tweetTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweetArray[indexPath.row];
    NSLog(@"%@", tweet.text);
    if(tweet.favorited)
    {
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    if(tweet.retweeted)
    {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    
    //needed to be able to favorite / retweet
    cell.tweet = tweet;
    //allows for the DateTools tool to be used (nevermind this would not work)
//    NSDate *date = tweet.createdAtDate;
//    NSString *timeSinceTweet= [NSString stringWithFormat:@"%@", NSDate date.timeIntervalSinceNow];
    
    
    cell.dateLabel.text = tweet.createdAtString;
    cell.nameLabel.text = tweet.user.name;
    NSString *concatenatedString = [@"@" stringByAppendingString:tweet.user.screenName ];
    concatenatedString = [concatenatedString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    cell.usernameLabel.text = concatenatedString;
    cell.tweetLabel.text = tweet.text;
    
    //gets nums of retweets and likes for NSString conversion
    int numFavorite =tweet.favoriteCount;
    int numRetweet = tweet.retweetCount;
    
    cell.numRetweetLabel.text =[@(numRetweet) stringValue];
    cell.numFavoritesLabel.text = [@(numFavorite) stringValue];
    
    NSURL *profileImageURLPath = [NSURL URLWithString:tweet.user.profileImagePath];
    [cell.profilepictureView setImageWithURL:profileImageURLPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}
  // Makes a network request to get updated data
  // Updates the tableView with the new data
  // Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshFeed {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweetArray = (NSMutableArray *) tweets;
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tweetTableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     UINavigationController *navigationController = [segue destinationViewController];
     ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
     composeController.delegate = self;
 }
 
- (void)didTweet:(nonnull Tweet *)tweet {
    //adds tweet that the user just sent out to the list of tweets to show
    [_tweetArray insertObject:tweet atIndex:0];
    //gets rid of the compose screen
    [self dismissViewControllerAnimated:true completion:nil];
    //calls for a reload of data
    [self.tweetTableView reloadData];
}

- (IBAction)logoutButton:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;

    [[APIManager shared] logout];
}


@end
