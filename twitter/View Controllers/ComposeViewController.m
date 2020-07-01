//
//  ComposeViewController.m
//  twitter
//
//  Created by gfloresv on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeLabel;

@end

@implementation ComposeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetAction:(id)sender {
    //grabs the text from inside of the text view to know what we're actually tweeting out
    NSString *tweet = self.composeLabel.text;
    //creates an instance of the api manager class in order to access the postStatusWithText method
    [[APIManager shared] postStatusWithText:tweet completion:^(Tweet *tweetObject, NSError *error) {
        if(error){
            NSLog(@"%@", error.localizedDescription);
        }
        else{
            //tweet is successful, get delegate to 'did tweet'
            [self.delegate didTweet:tweetObject];
            NSLog(@"Compose Tweet Success!");
        }
    }];
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
