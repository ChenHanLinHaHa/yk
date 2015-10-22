//
//  PhotoBrowerHelper.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/13.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "PhotoBrowerHelper.h"

@interface PhotoBrowerHelper()
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@end

@implementation PhotoBrowerHelper

+(PhotoBrowerHelper *)defaultPhotoBrowerHelper {
    static PhotoBrowerHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[PhotoBrowerHelper alloc] init];
    });
    return helper;
}


- (NSMutableArray *)photos
{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc] init];
    }
    
    return _photos;
}

- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}


#pragma mark - private


#pragma mark - public

- (void)showBrowserWithImages:(NSArray *)imageArray
{
    if (imageArray && [imageArray count] > 0) {
        NSMutableArray *photoArray = [NSMutableArray array];
        for (id object in imageArray) {
            MWPhoto *photo;
            if ([object isKindOfClass:[UIImage class]]) {
                photo = [MWPhoto photoWithImage:object];
            }
            else if ([object isKindOfClass:[NSString class]])
            {
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:object]];
            }
            [photoArray addObject:photo];
        }
        
        self.photos = photoArray;
    }
    
    [selected_navigation_controller() presentViewController:self.photoNavigationController animated:YES completion:nil];
}


@end
