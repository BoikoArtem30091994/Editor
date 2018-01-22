//
//  CollectionItemView.m
//  Editor
//
//  Created by Artem on 1/16/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "CollectionItemView.h"

@implementation CollectionItemView

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//
//}

- (void)drawRect:(NSRect)dirtyRect
{
    if (_selected) {
        [[NSColor lightGrayColor] set];
        NSFrameRect([self bounds]);
    }
}

@end
