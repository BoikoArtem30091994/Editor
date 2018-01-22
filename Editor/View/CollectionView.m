//
//  CollectionView.m
//  Editor
//
//  Created by Artem on 1/16/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark: Drag and Drop

//- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
//{
//    NSPasteboard *pboard;
//    NSDragOperation sourceDragMask;
//
//    sourceDragMask = [sender draggingSourceOperationMask];
//    pboard = [sender draggingPasteboard];
//
//    if ( [[pboard types] containsObject:NSFilenamesPboardType] )
//    {
//        return NSDragOperationCopy;
//    }
//    return NSDragOperationNone;
//}
//
//- (void)draggingEnded:(id<NSDraggingInfo>)sender {
//    if(NSPointInRect([sender draggingLocation],self.frame)){
//        //The file was actually dropped on the view so call the performDrag manually
//        [self performDragOperation:sender];
//    }
//}
//
//- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
//
//    NSPasteboard *pboard;
//    NSDragOperation sourceDragMask;
//
//    sourceDragMask = [sender draggingSourceOperationMask];
//    pboard = [sender draggingPasteboard];
//
//    if ( [[pboard types] containsObject:NSFilenamesPboardType] )
//    {
//        NSArray * pastboardArray = [[NSArray alloc]init];
//        pastboardArray = [pboard propertyListForType:NSFilenamesPboardType];
//
//        [self.viewController downloadImagesPastboard:pastboardArray];
//
//        return YES;
//    }
//    return YES;
//}

@end
