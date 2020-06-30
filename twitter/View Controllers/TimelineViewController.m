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
@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;
//@property (weak, nonatomic) IBOutlet UITableView *tweetView;


@property (nonatomic, strong) NSMutableArray *tweetArray;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTableView.dataSource = self;
    self.tweetTableView.delegate = self;
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
    
    cell.dateLabel.text = tweet.createdAtString;
    cell.nameLabel.text = tweet.user.name;
    NSString *concatenatedString = [@"@" stringByAppendingString:tweet.user.screenName ];
    concatenatedString = [concatenatedString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    cell.usernameLabel.text = concatenatedString;
    cell.tweetLabel.text = tweet.text;
    NSURL *profileImageURLPath = [NSURL URLWithString:tweet.user.profileImagePath];
    [cell.profilepictureView setImageWithURL:profileImageURLPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
