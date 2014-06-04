//  Copyright (c) 2014年 KoheiKanagu. All rights reserved.

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface KKImageViewerController : UIViewController <UINavigationControllerDelegate, UINavigationBarDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    BOOL hiddenStatusBar;
}

@property IBOutlet UIScrollView *mainScrollView;
@property UIImageView *mainImageView;
@property UIImage *sourceImage;

@end
