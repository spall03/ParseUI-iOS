/*
 *  Copyright (c) 2014, Facebook, Inc. All rights reserved.
 *
 *  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
 *  copy, modify, and distribute this software in source code or binary form for use
 *  in connection with the web services and APIs provided by Facebook.
 *
 *  As with any software that integrates with the Facebook platform, your use of
 *  this software is subject to the Facebook Developer Principles and Policies
 *  [http://developers.facebook.com/policy/]. This copyright notice shall be
 *  included in all copies or substantial portions of the software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#import "PFCollectionViewCell.h"

#import "PFImageView.h"
#import "PFRect.h"

@implementation PFCollectionViewCell

@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews {
    [super layoutSubviews];

    const CGRect bounds = self.contentView.bounds;

    CGRect imageViewFrame = CGRectZero;
    if (_imageView && _imageView.image){
        imageViewFrame = PFRectMakeWithSizeCenteredInRect(PFSizeMin(_imageView.image.size, bounds.size),
                                                          bounds);
    }
    CGRect textLabelFrame = CGRectZero;
    if (_textLabel) {
        CGSize imageSize = CGSizeMake(CGRectGetWidth(imageViewFrame),
                                      MIN(CGRectGetHeight(imageViewFrame), CGRectGetHeight(bounds) / 3.0f));
        imageViewFrame = PFRectMakeWithSize(imageSize);
        textLabelFrame = PFRectMakeWithOriginSize(CGPointMake(0.0f, CGRectGetMaxY(imageViewFrame)),
                                                  CGSizeMake(CGRectGetWidth(bounds), CGRectGetHeight(bounds) - CGRectGetMaxY(imageViewFrame)));
    }

    _imageView.frame = CGRectIntegral(imageViewFrame);
    _textLabel.frame = CGRectIntegral(textLabelFrame);
}

#pragma mark -
#pragma mark Update

- (void)updateFromObject:(PFObject *)object {
    // Do nothing
}

#pragma mark -
#pragma mark Accessors

- (PFImageView *)imageView {
    if (!_imageView) {
        _imageView = [[PFImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
    }
    return _textLabel;
}

@end
