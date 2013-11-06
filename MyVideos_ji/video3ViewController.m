//
//  video3ViewController.m
//  MyVideos_ji
//
//  Created by June Scheri on 11/5/13.
//  Copyright (c) 2013 RVC Student. All rights reserved.
//

#import "video3ViewController.h"

@interface video3ViewController ()

@end

@implementation video3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //Change to match you video filename in supporting files
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if([self checkinternet] == NO)
    {
        // Not connected to the internet
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required"
                                                          message:@"Close app and return when internet connection available."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
        
    {
        //Change to match you video filename in supporting files
        NSString *url = [[NSBundle mainBundle]
                         pathForResource:@"video3"
                         ofType:@"mp4"];
        
        player = [[MPMoviePlayerController alloc]
                  initWithContentURL:[NSURL fileURLWithPath:url]];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(movieFinishedCallback:)
         name:MPMoviePlayerPlaybackDidFinishNotification
         object:player];
        
        //—set the size of the movie view and then add it to the View window—
        //get screensize
        CGSize size = [self getScreenSize];
        player.view.frame = CGRectMake(0, 50, size.width,size.height);
        [self.view addSubview:player.view];
        
        //—play movie—
        [player play];
    }
}
//copy paste right below viewdidload
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *moviePlayer = [aNotification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:moviePlayer];
    [moviePlayer.view removeFromSuperview];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    //Stop Player when Back button  caused view to disappear
    [player stop];
	[super viewDidDisappear:animated];
}
- (CGSize)getScreenSize
{
    //Get Screen size
    CGSize size;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) && [[UIScreen mainScreen] bounds].size.height > [[UIScreen mainScreen] bounds].size.width) {
        // in Landscape mode, width always higher than height
        size.width = [[UIScreen mainScreen] bounds].size.height;
        size.height = [[UIScreen mainScreen] bounds].size.width;
    } else if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && [[UIScreen mainScreen] bounds].size.height < [[UIScreen mainScreen] bounds].size.width) {
        // in Portrait mode, height always higher than width
        size.width = [[UIScreen mainScreen] bounds].size.height;
        size.height = [[UIScreen mainScreen] bounds].size.width;
    } else {
        // otherwise it is normal
        size.height = [[UIScreen mainScreen] bounds].size.height;
        size.width = [[UIScreen mainScreen] bounds].size.width;
    }
    return size;
}
- (BOOL) checkinternet
{
    //check internet connection
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
    {
        NSLog(@"Device is connected to the internet");
        return YES;
    }
    else
    {
        NSLog(@"Device is not connected to the internet");
        return NO;
    }
    
}



@end
