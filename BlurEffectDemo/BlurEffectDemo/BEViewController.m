//
//  BEViewController.m
//  BlurEffectDemo
//
//  Created by Romain ASNAR on 05/11/2013.
//  Copyright (c) 2013 Romain ASNAR. All rights reserved.
//

#import "BEViewController.h"

// Import Apple Blur Effect
#import "UIImage+ImageEffects.h"

@interface BEViewController ()

@end

@implementation BEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayBlurNotification:(id)sender
{
    // Add blurred background view to content view.
    [self addBlurredBackgroundView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.hasDisplayedNotification == YES) {
        [self removeBlurredBackgroundView];
    }
}

#pragma mark - Blur effect

- (void)addBlurredBackgroundView
{
    UIImage *blurredSnapshotImage = [self createblurredSnapshotImage];

    // Create a background image view with blurred snapshot.
    self.backgroundBlurred = [[UIImageView alloc] initWithImage:blurredSnapshotImage];

    // Use this content mode to not resize the image.
    self.backgroundBlurred.contentMode = UIViewContentModeTop;

    // Clips to bounds to not display the image if the height is egual to zero.
    self.backgroundBlurred.clipsToBounds = YES;

    // Start frame is set to not display the background image.
    CGRect startFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0);

    // End frame is set to display in full screen.
    CGRect endFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));

    // Set the start frame to background view.
    self.backgroundBlurred.frame  = startFrame;

    // Add background view to parent view.
    [self.view addSubview:self.backgroundBlurred];

    // Animate the background view to display the snapshot with blur effect.
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundBlurred.frame  = endFrame;
    } completion:^(BOOL finished) {
        self.hasDisplayedNotification = YES;
        self.displayBlurNotificationButton.enabled = NO;
    }];
}

- (void)removeBlurredBackgroundView
{
    // End frame is set to display in full screen.
    CGRect endFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0);

    // Animate the background view to display the snapshot with blur effect.
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundBlurred.frame  = endFrame;
    } completion:^(BOOL finished) {
        self.hasDisplayedNotification = NO;
        [self.backgroundBlurred removeFromSuperview];
        self.displayBlurNotificationButton.enabled = YES;
    }];
}

- (UIImage*)createblurredSnapshotImage
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.0);

    // There he is! The new API method
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    [self.view drawViewHierarchyInRect:rect afterScreenUpdates:NO];

    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();

    // Be nice and clean your mess up
    UIGraphicsEndImageContext();

    // Blur the snapshot
    UIImage *blurredSnapshotImage = [snapshotImage applyDarkEffect];

    return blurredSnapshotImage;
}

@end
