//
//  WebViewController.h
//  Editor
//
//  Created by Artem on 1/30/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface WebViewController : NSViewController <WKNavigationDelegate>

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet WKWebView *webView;
@property (weak) IBOutlet NSTextField *webViewActiveUrl;



@end
