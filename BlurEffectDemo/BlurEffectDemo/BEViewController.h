//
//  BEViewController.h
//  BlurEffectDemo
//
//  Created by Romain ASNAR on 05/11/2013.
//  Copyright (c) 2013 Romain ASNAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BEViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *displayBlurNotificationButton;

@property (strong, nonatomic) UIImageView *backgroundBlurred;
@property (assign, nonatomic) BOOL hasDisplayedNotification;

- (IBAction)displayBlurNotification:(id)sender;

#pragma mark - Blur Effect

- (void)addBlurredBackgroundView;
- (UIImage*)createblurredSnapshotImage;

@end
