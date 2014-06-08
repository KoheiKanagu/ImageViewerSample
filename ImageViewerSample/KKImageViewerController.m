//  Copyright (c) 2014年 KoheiKanagu. All rights reserved.

#import "KKImageViewerController.h"

@implementation KKImageViewerController

-(void)viewDidLoad
{
    [super viewDidLoad];
    hiddenStatusBar = NO;
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self.mainScrollView setDelegate:self];
    [self.mainScrollView setMaximumZoomScale:5.0];
    [self.mainScrollView setAlwaysBounceHorizontal:YES];
    [self.mainScrollView setAlwaysBounceVertical:YES];

    self.mainImageView = [[UIImageView alloc]initWithImage:self.sourceImage];
    [self.mainImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapGesture:)];
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(doubleTapGesture:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    [self.mainImageView addGestureRecognizer:tapGesture];
    [self.mainImageView addGestureRecognizer:doubleTapGesture];
    
    [self.mainScrollView addSubview:self.mainImageView];
}

-(void)viewWillAppear:(BOOL)animated
{
    CGRect frame = AVMakeRectWithAspectRatioInsideRect(self.mainImageView.image.size, self.view.bounds);
    [self.mainImageView setFrame:frame];
}

-(BOOL)prefersStatusBarHidden
{
    return hiddenStatusBar;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation
//{
//    return UIStatusBarAnimationFade;
//}

#pragma mark -
#pragma mark Gesture

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.mainScrollView setZoomScale:1.0
                        animated:NO];
    [self viewWillAppear:YES];
}



#pragma mark - Scroll

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGRect imageViewFrame = self.mainImageView.frame;
    CGRect scrollViewBounds = self.mainScrollView.bounds;
    
    if(imageViewFrame.size.width < scrollViewBounds.size.width){
        imageViewFrame.origin.x = (scrollViewBounds.size.width - imageViewFrame.size.width)/2;
    }else{
        imageViewFrame.origin.x = 0;
    }
    
    if(imageViewFrame.size.height < scrollViewBounds.size.height){
        imageViewFrame.origin.y = (scrollViewBounds.size.height - imageViewFrame.size.height)/2;
    }else{
        imageViewFrame.origin.y = 0;
    }
    
    self.mainImageView.frame = imageViewFrame;
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mainImageView;
}




#pragma mark Tap

-(void)doubleTapGesture:(UIGestureRecognizer *)sender
{
    if([self.mainScrollView zoomScale] > 1){
        [self.mainScrollView setZoomScale:1.0
                            animated:YES];
    }else{
        [self.mainScrollView setZoomScale:3
                            animated:YES];
    }
}

-(void)tapGesture:(UIGestureRecognizer *)sender
{
    if([self.navigationController isNavigationBarHidden]){
        hiddenStatusBar = NO;
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self setNeedsStatusBarAppearanceUpdate];
                             self.mainScrollView.backgroundColor = [UIColor whiteColor];
                             
                             [self.navigationController setNavigationBarHidden:NO
                                                                      animated:YES];
                             [self.navigationController setToolbarHidden:NO
                                                                animated:YES];
                         }completion:^(BOOL finished){
                         }];
    }else{
        hiddenStatusBar = YES;
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self setNeedsStatusBarAppearanceUpdate];
                             self.mainScrollView.backgroundColor = [UIColor blackColor];

                             [self.navigationController setNavigationBarHidden:YES
                                                                      animated:YES];
                             [self.navigationController setToolbarHidden:YES
                                                                animated:YES];
                         }completion:^(BOOL finished){
                         }];
    }
}

@end
