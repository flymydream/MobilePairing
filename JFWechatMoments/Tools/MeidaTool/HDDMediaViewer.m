//
//  HDDMediaViewer.m
//  Driver
//
//  Created by caesar on 2020/7/1.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDMediaViewer.h"
#import <KSPhotoBrowser.h>


@implementation HDDMediaViewer

+ (void)showImage:(NSString *)imageURL withSourceView:(UIImageView *)sourceView{
    [self showImages:@[imageURL] withSourceView:sourceView atIndex:0];
}

+ (void)showImages:(NSArray *)imageURLs withSourceView:(UIImageView *)sourceView atIndex:(NSInteger)index{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imageURLs.count; i++) {
        NSString *url = imageURLs[i];
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:i == index?sourceView:nil imageUrl:[NSURL URLWithString:url]];
        [items addObject:item];
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:index];
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleScale;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlurPhoto;
    browser.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:browser animated:NO completion:nil];
}

@end
