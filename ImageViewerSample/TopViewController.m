//
//  TopViewController.m
//  ImageViewerSample
//
//  Created by Kohei on 2014/05/30.
//  Copyright (c) 2014年 KoheiKanagu. All rights reserved.
//

#import "TopViewController.h"

@implementation TopViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = @"Sample";
    cell.detailTextLabel.text = @"hogehoge";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"Show"
                              sender:nil];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show"]){
        KKImageViewerController *hoge = (KKImageViewerController *)[segue destinationViewController];
        [hoge setSourceImage:[UIImage imageNamed:@"hero.jpg"]];
        [hoge setMainScrollView:[[UIScrollView alloc]initWithFrame:self.view.frame]];
    }
}

@end
