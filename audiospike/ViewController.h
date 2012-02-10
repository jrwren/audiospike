//
//  ViewController.h
//  audiospike
//
//  Created by Jay R Wren on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    BOOL paused;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UISlider *volumeSlider;
- (IBAction)buttonTouched:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mpVolumeViewParentView;

@end
