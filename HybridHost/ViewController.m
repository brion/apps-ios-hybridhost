//
//  ViewController.m
//  HybridHost
//
//  Created by Brion on 9/1/13.
//  Copyright (c) 2013 Brion Vibber. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Allow programatically triggering search UI in web view
    self.webView.keyboardDisplayRequiresUserAction = NO;

    [self loadFirstPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navbar button handlers

- (IBAction)menuButtonPushed:(id)sender {
    [self clickElementBySelector:@"#mw-mf-main-menu-button"];
}

- (IBAction)searchButtonPushed:(id)sender {
    [self focusElementBySelector:@"#searchInput"];
}

#pragma mark Toolbar button handlers

- (IBAction)backButtonPushed:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardButtonPushed:(id)sender {
    [self.webView goForward];
}

- (IBAction)languageButtonPushed:(id)sender {
    [self clickElementBySelector:@"button.languageSelector"];
}

- (IBAction)actionButtonPushed:(id)sender {
}

- (IBAction)bookmarkButtonPushed:(id)sender {
}

#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([self isWikipediaURL:request.URL]) {
        return YES;
    } else {
        [self openURLInExternalBrowser:request.URL];
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webView didFailLoadWithError: %@", error);
}

#pragma mark private methods

- (void)loadFirstPage {
    NSString *urlString = @"https://en.m.wikipedia.org/wiki/";
    [self loadURL:[NSURL URLWithString:urlString]];
}

- (void)loadURL:(NSURL *)url {
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (BOOL)isWikipediaURL:(NSURL *)url {
    if ([url.host isEqualToString:@"login.wikimedia.org"]) {
        return YES;
    }
    NSArray *domainChunks = [url.host componentsSeparatedByString:@"."];
    NSUInteger chunks = domainChunks.count;
    if (chunks < 3) {
        return NO;
    }
    NSString *top = domainChunks[chunks - 1];
    NSString *domain = domainChunks[chunks - 2];
    NSString *subdomain = domainChunks[chunks - 3];
    if (![top isEqualToString:@"org"]) {
        return NO;
    }
    if (![domain isEqualToString:@"wikipedia"]) {
        return NO;
    }
    if (![subdomain isEqualToString:@"m"]) {
        return NO;
    }
    return YES;
}

- (void)openURLInExternalBrowser:(NSURL *)url {
    // FIXME add other browser support
    [UIApplication.sharedApplication openURL:url];
}

- (BOOL)clickElementBySelector:(NSString *)sel {
    return [self callElementBySelector:sel method:@"click"];
}

- (BOOL)focusElementBySelector:(NSString *)sel {
    return [self callElementBySelector:sel method:@"focus"];
}

- (BOOL)callElementBySelector:(NSString *)sel method:(NSString *)method {
    // FIXME escape string
    NSString *js = [NSString stringWithFormat:@"document.querySelector(\"%@\").%@();", sel, method];
    return [self runJavaScript:js];
}

- (BOOL)runJavaScript:(NSString *)js {
    NSString *wrapper = [NSString stringWithFormat:@"(function() {\ntry {\nreturn (function() {\n%@\n})();\n}\ncatch(e) {\nreturn 'error:' + e;\n}\n})()\n", js];
    NSLog(@"Running JS: %@", wrapper);
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:wrapper];
    NSLog(@"JS result: %@", result);
    return YES;
}

@end
