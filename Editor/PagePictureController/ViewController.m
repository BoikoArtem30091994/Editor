//
//  ViewController.m
//  Editor
//
//  Created by Artem Boiko on 16.01.2018.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "ViewController.h"
#import "ImageFile.h"


@implementation ViewController{
    NSMutableArray <NSIndexPath *> *indexPathsOfDraggedItems;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView reloadData];
    
    _arrayCollection = [[NSMutableArray alloc]init];
    
    // register types that we accept
    [self.collectionView registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, NSURLPboardType, NSTIFFPboardType,  nil]];
    
    // Enable dragging items from our CollectionView to other applications.
    [self.collectionView setDraggingSourceOperationMask:NSDragOperationEvery forLocal:NO];
    
    // Enable dragging items within and into our CollectionView.
    [self.collectionView setDraggingSourceOperationMask:NSDragOperationEvery forLocal:YES];

}

-(void)viewWillAppear{
    NSColor * newColor =nil;
    NSData *saveData=[[NSUserDefaults standardUserDefaults] dataForKey:@"colorPreference"];
    if (saveData != nil) {
        newColor =(NSColor *)[NSKeyedUnarchiver unarchiveObjectWithData:saveData];
        self.view.layer.backgroundColor = newColor.CGColor;
    } else {
        self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    }
}

-(void)viewWillDisappear{
    NSColor *saveColor = self.colorPalette.color;
    NSData *colorData=[NSKeyedArchiver archivedDataWithRootObject:saveColor];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"colorPreference"];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

#pragma mark: Download Images

-(void) downloadImages:(NSArray*) arrayURLS{
    //    [_arrayCollection removeAllObjects];
    for (int n=0; n<arrayURLS.count; n++) {
        NSImage *image = [[NSImage alloc]initWithContentsOfURL: [arrayURLS objectAtIndex:n]];
        [_arrayCollection addObject:image];
    }
    [self.collectionView reloadData];
}

-(void) downloadImagesPastboard:(NSArray*) arrayURLS{
    for (int n=0; n<arrayURLS.count; n++) {
        NSImage *image = [[NSImage alloc]initWithContentsOfFile:[arrayURLS objectAtIndex:n]];
        [_arrayCollection addObject:image];
    }
    [self.collectionView reloadData];
}

- (void)moveItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    NSUInteger imageFilesCount = self.arrayCollection.count;
    NSParameterAssert(fromIndex < imageFilesCount);
    NSImage *image = [self.arrayCollection objectAtIndex:fromIndex];
    [self.arrayCollection removeObjectAtIndex:fromIndex];
    [self.arrayCollection insertObject:image atIndex:(toIndex <= fromIndex) ? toIndex : (toIndex - 1)];
    
}
#pragma mark: set and get image for document

-(NSMutableArray*) getImageForDocument {
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:_arrayCollection];
    return array;
}

-(void) setImageFromDocument:(NSMutableArray*) array{
    [_arrayCollection addObjectsFromArray:array];
    [_collectionView reloadData];
}

#pragma mark: CollectionViewDataSource

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrayCollection.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSCollectionViewItem *item = [collectionView makeItemWithIdentifier:@"CollectionItem" forIndexPath:indexPath];
    item.imageView.image = [_arrayCollection objectAtIndex:[indexPath item]];
    return item;
}

#pragma mark Dragging Related delegate methods

/*******************/
/* Dragging Source */
/*******************/

- (BOOL)collectionView:(NSCollectionView *)collectionView canDragItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths withEvent:(NSEvent *)event{
    return YES;
}

- (id <NSPasteboardWriting>)collectionView:(NSCollectionView *)collectionView pasteboardWriterForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSImage *image = [_arrayCollection objectAtIndex:indexPath.item];
    return image;
}

- (void)collectionView:(NSCollectionView *)collectionView draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    
    indexPathsOfDraggedItems = [[NSMutableArray alloc] initWithArray: [indexPaths allObjects]];
    
}

-(void)collectionView:(NSCollectionView *)collectionView draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint dragOperation:(NSDragOperation)operation{
    
    indexPathsOfDraggedItems= nil;
}


/************************/
/* Dragging Destination */
/************************/

-(NSDragOperation)collectionView:(NSCollectionView *)collectionView validateDrop:(id<NSDraggingInfo>)draggingInfo proposedIndexPath:(NSIndexPath **)proposedDropIndexPath dropOperation:(NSCollectionViewDropOperation *)proposedDropOperation
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [draggingInfo draggingSourceOperationMask];
    pboard = [draggingInfo draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] )
    {
        return NSDragOperationCopy;
    }
    
    if ([[pboard types] containsObject: NSURLPboardType]) {
        return NSDragOperationMove;
    }
    
    if ([[pboard types] containsObject: NSTIFFPboardType]) {
        return NSDragOperationMove;
    }
    
        return NSDragOperationNone;
    
    
}

-(BOOL)collectionView:(NSCollectionView *)collectionView acceptDrop:(id<NSDraggingInfo>)draggingInfo indexPath:(NSIndexPath *)indexPath dropOperation:(NSCollectionViewDropOperation)dropOperation
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [draggingInfo draggingSourceOperationMask];
    pboard = [draggingInfo draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] )
    {
        NSArray * pastboardArray = [pboard propertyListForType:NSFilenamesPboardType];

        for (int n=0; n<pastboardArray.count; n++) {
            NSString *str = [pastboardArray objectAtIndex:n];
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:str];
            [_arrayCollection insertObject:image atIndex: indexPath.item];
        }
        [_collectionView reloadData];
        return YES;
    }
    
    if ([[pboard types] containsObject: NSURLPboardType])
    {

        NSLog(@"NSURLPboardType");
        NSArray * pastboardArray = [pboard propertyListForType:NSURLPboardType];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [pastboardArray objectAtIndex:0]]];
        NSImage *image = [[NSImage alloc] initWithData:imageData];
        [_arrayCollection insertObject:image atIndex:indexPath.item];
        [collectionView reloadData];

        return YES;
    }
    
    if ( [[pboard types] containsObject:NSTIFFPboardType] )
    {
    
        if(NSPointInRect([draggingInfo draggingLocation],self.collectionView.frame)){
            
//            BACK MOVE

            __block NSInteger toItemIndex = indexPath.item ;
            [indexPathsOfDraggedItems enumerateObjectsWithOptions:0 usingBlock:^(NSIndexPath * fromIndexPath, NSUInteger idx, BOOL *stop) {
                NSInteger fromItemIndex = fromIndexPath.item;
                if (fromItemIndex > toItemIndex) {
    
                    [self moveItemFromIndex:fromItemIndex toIndex:toItemIndex];
                    
                    [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:fromItemIndex inSection:[indexPath section]] toIndexPath:[NSIndexPath indexPathForItem:toItemIndex inSection:[indexPath section]]];
                    
                        // Advance to maintain moved items in their original order.
                        ++toItemIndex;
                    }
            }];

//            FORWARD MOVE
            
            __block NSInteger adjustedToItemIndex = indexPath.item - 1;
            [indexPathsOfDraggedItems enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSIndexPath * fromIndexPath, NSUInteger idx, BOOL * stop) {
                NSInteger fromItemIndex = [fromIndexPath item];
                if (fromItemIndex < adjustedToItemIndex) {
                
                [self moveItemFromIndex:fromItemIndex toIndex:toItemIndex];
                    
                NSIndexPath *adjustedToIndexPath = [NSIndexPath indexPathForItem:adjustedToItemIndex inSection:[indexPath section]];
                [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:fromItemIndex inSection:indexPath.section] toIndexPath:adjustedToIndexPath];
                    
                --adjustedToItemIndex;
                }
            }];
        }

//        NSMutableArray *droppedObjects = [NSMutableArray array];
//        [draggingInfo enumerateDraggingItemsWithOptions: 0
//                                                forView: collectionView
//                                                classes: @[[NSImage class]]
//                                          searchOptions: nil usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop)
//        {
//
//            NSImage *url = draggingItem.item;
//            if ([url isKindOfClass:[NSImage class]]) {
//                [droppedObjects addObject:url];
//            }
//        }];
//
//        NSArray * pastboardArray1 = [pboard propertyListForType:NSTIFFPboardType];
//
//        id pastboardArray = [pboard dataForType:NSTIFFPboardType];
//
//        NSImage *image = [[NSImage alloc] initWithData: pastboardArray];
//
//        [_arrayCollection insertObject:image atIndex: 0];
//
//        [_collectionView reloadData];
//
//        return YES;
    }
    
    return YES;
}


#pragma mark: Actions

- (IBAction)openBtn:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:YES];
    
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSModalResponseOK) {
            // Open  the document.
            [self downloadImages:[panel URLs]];
        }
    }];
}

- (IBAction)deleteImageBtn:(id)sender {
    NSIndexSet* selectedIndexSet = [_collectionView selectionIndexes];
    [_arrayCollection removeObjectsAtIndexes:selectedIndexSet];
    [_collectionView reloadData];
}

- (IBAction)deleteAllImage:(id)sender {
    [_arrayCollection removeAllObjects];
    [_collectionView reloadData];
    
}

- (IBAction)changeBackgroundColor:(id)sender {
    self.view.layer.backgroundColor = self.colorPalette.color.CGColor;
}

- (IBAction)defaultSettings:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"colorPreference"];
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;

}


@end
