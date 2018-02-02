//
//  WebViewController.m
//  Editor
//
//  Created by Artem on 1/30/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@end

@implementation WebViewController

static NSString * progress = @"estimatedProgress";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self.webView addObserver:self forKeyPath:progress options:NSKeyValueObservingOptionNew context:nil];
    self.webView.navigationDelegate = self;
    [self webViewUrlRequest];
    
}

-(void) webViewUrlRequest{
    NSString *urlString = @"https://depositphotos.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}


-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (keyPath == progress) {
//            NSLog(@"Loaded %f ", self.webView.estimatedProgress);
            [self.progressIndicator setDoubleValue:self.webView.estimatedProgress * 100.0];
        }
}

#pragma mark: WKNavigationDelegate

//UIWebView => WKWebView Equivalent
//--------------------------------------------------------------
//webViewDidFinishLoad => didFinishNavigation
//webViewDidStartLoad => didStartProvisionalNavigation


-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressIndicator.hidden = FALSE;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    self.progressIndicator.hidden = TRUE;
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:progress];
}

@end
