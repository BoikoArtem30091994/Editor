//
//  CollectionItem.m
//  Editor
//
//  Created by Artem on 1/16/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "CollectionItem.h"

@interface CollectionItem ()

@end

@implementation CollectionItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)setSelected:(BOOL)flag
{
    [super setSelected:flag];
    [(CollectionItemView*)[self view] setSelected:flag];
    [(CollectionItemView*)[self view] setNeedsDisplay:YES];
}

@end
