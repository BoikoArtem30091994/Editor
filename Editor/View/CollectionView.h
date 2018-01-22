//
//  CollectionView.h
//  Editor
//
//  Created by Artem on 1/16/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"
#import "CollectionItem.h"

@interface CollectionView : NSCollectionView

@property (weak) IBOutlet ViewController *viewController;




@end
