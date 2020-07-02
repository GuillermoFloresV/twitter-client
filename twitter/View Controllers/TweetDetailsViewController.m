//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by gfloresv on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
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
    // Do any additional setup after loading the view.
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
