//
//  PureLayoutDefines.h
//  v2.0.0
//  https://github.com/smileyborg/PureLayout
//
//  Copyright (c) 2014 Tyler Fox
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#ifndef PureLayoutDefines_h
#define PureLayoutDefines_h

#import <Foundation/Foundation.h>

#define __PureLayout_MinBaseSDK_iOS8                    TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
#define __PureLayout_MinSysVer_iOS7                     floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1
#define __PureLayout_MinSysVer_iOS8                     floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1

#if TARGET_OS_IPHONE

    #import <UIKit/UIKit.h>

    #define ALView                                      UIView
    #define ALEdgeInsets                                UIEdgeInsets
    #define ALEdgeInsetsZero                            UIEdgeInsetsZero
    #define ALEdgeInsetsMake                            UIEdgeInsetsMake
    #define ALLayoutConstraintAxis                      UILayoutConstraintAxis
    #define ALLayoutConstraintOrientation               ALLayoutConstraintAxis
    #define ALLayoutConstraintAxisHorizontal            UILayoutConstraintAxisHorizontal
    #define ALLayoutConstraintAxisVertical              UILayoutConstraintAxisVertical
    #define ALLayoutConstraintOrientationHorizontal     ALLayoutConstraintAxisHorizontal
    #define ALLayoutConstraintOrientationVertical       ALLayoutConstraintAxisVertical
    #define ALLayoutPriority                            UILayoutPriority
    #define ALLayoutPriorityRequired                    UILayoutPriorityRequired
    #define ALLayoutPriorityDefaultHigh                 UILayoutPriorityDefaultHigh
    #define ALLayoutPriorityDefaultLow                  UILayoutPriorityDefaultLow
    #define ALLayoutPriorityFittingSizeLevel            UILayoutPriorityFittingSizeLevel
    #define ALLayoutPriorityFittingSizeCompression      ALLayoutPriorityFittingSizeLevel

#else

    #import <Cocoa/Cocoa.h>

    #define ALView                                      NSView
    #define ALEdgeInsets                                NSEdgeInsets
    #define ALEdgeInsetsZero                            NSEdgeInsetsMake(0, 0, 0, 0)
    #define ALEdgeInsetsMake                            NSEdgeInsetsMake
    #define ALLayoutConstraintOrientation               NSLayoutConstraintOrientation
    #define ALLayoutConstraintAxis                      ALLayoutConstraintOrientation
    #define ALLayoutConstraintOrientationHorizontal     NSLayoutConstraintOrientationHorizontal
    #define ALLayoutConstraintOrientationVertical       NSLayoutConstraintOrientationVertical
    #define ALLayoutConstraintAxisHorizontal            ALLayoutConstraintOrientationHorizontal
    #define ALLayoutConstraintAxisVertical              ALLayoutConstraintOrientationVertical
    #define ALLayoutPriority                            NSLayoutPriority
    #define ALLayoutPriorityRequired                    NSLayoutPriorityRequired
    #define ALLayoutPriorityDefaultHigh                 NSLayoutPriorityDefaultHigh
    #define ALLayoutPriorityDefaultLow                  NSLayoutPriorityDefaultLow
    #define ALLayoutPriorityFittingSizeCompression      NSLayoutPriorityFittingSizeCompression
    #define ALLayoutPriorityFittingSizeLevel            ALLayoutPriorityFittingSizeCompression

#endif /* TARGET_OS_IPHONE */


#pragma mark ALAttributes

/** An attribute of a view that can be used in auto layout constraints. Can be any of the enum types: ALEdge, ALAxis, ALDimension, ALMargin, ALMarginAxis. */
typedef NSInteger ALAttribute;

/** Constants that represent edges of a view. */
typedef NS_ENUM(NSInteger, ALEdge) {
    /** The left edge of the view. */
    ALEdgeLeft = NSLayoutAttributeLeft,
    /** The right edge of the view. */
    ALEdgeRight = NSLayoutAttributeRight,
    /** The top edge of the view. */
    ALEdgeTop = NSLayoutAttributeTop,
    /** The bottom edge of the view. */
    ALEdgeBottom = NSLayoutAttributeBottom,
    /** The leading edge of the view (left edge for left-to-right languages like English, right edge for right-to-left languages like Arabic). */
    ALEdgeLeading = NSLayoutAttributeLeading,
    /** The trailing edge of the view (right edge for left-to-right languages like English, left edge for right-to-left languages like Arabic). */
    ALEdgeTrailing = NSLayoutAttributeTrailing
};

/** Constants that represent dimensions of a view. */
typedef NS_ENUM(NSInteger, ALDimension) {
    /** The width of the view. */
    ALDimensionWidth = NSLayoutAttributeWidth,
    /** The height of the view. */
    ALDimensionHeight = NSLayoutAttributeHeight
};

/** Constants that represent axes of a view. */
typedef NS_ENUM(NSInteger, ALAxis) {
    /** A vertical line through the middle of the view's left and right edges. */
    ALAxisVertical = NSLayoutAttributeCenterX,
    /** A horizontal line through the middle of the view's top and bottom edges. */
    ALAxisHorizontal = NSLayoutAttributeCenterY,
    
    /** A horizontal line at the baseline of the last line of text in the view. (For views that do not draw text, will be equivalent to ALEdgeBottom.) Same as ALAxisLastBaseline. */
    ALAxisBaseline = NSLayoutAttributeBaseline,
    /** A horizontal line at the baseline of the last line of text in the view. (For views that do not draw text, will be equivalent to ALEdgeBottom.) */
    ALAxisLastBaseline = ALAxisBaseline,
    #if __PureLayout_MinBaseSDK_iOS8
    /** A horizontal line at the baseline of the first line of text in a view. (For views that do not draw text, will be equivalent to ALEdgeTop.) Available in iOS 8.0 and later. */
    ALAxisFirstBaseline = NSLayoutAttributeFirstBaseline
    #endif /* __PureLayout_MinBaseSDK_iOS8 */
};

#if __PureLayout_MinBaseSDK_iOS8
/** Constants that represent layout margins of a view. Available in iOS 8.0 and later. */
typedef NS_ENUM(NSInteger, ALMargin) {
    /** The left margin of the view, based on the view's layoutMargins left inset. */
    ALMarginLeft = NSLayoutAttributeLeftMargin,
    /** The right margin of the view, based on the view's layoutMargins right inset. */
    ALMarginRight = NSLayoutAttributeRightMargin,
    /** The top margin of the view, based on the view's layoutMargins top inset. */
    ALMarginTop = NSLayoutAttributeTopMargin,
    /** The bottom margin of the view, based on the view's layoutMargins bottom inset. */
    ALMarginBottom = NSLayoutAttributeBottomMargin,
    /** The leading margin of the view, based on the view's layoutMargins left/right (depending on language direction) inset. */
    ALMarginLeading = NSLayoutAttributeLeadingMargin,
    /** The trailing margin of the view, based on the view's layoutMargins left/right (depending on language direction) inset. */
    ALMarginTrailing = NSLayoutAttributeTrailingMargin
};

/** Constants that represent axes of the layout margins of a view. Available in iOS 8.0 and later. */
typedef NS_ENUM(NSInteger, ALMarginAxis) {
    /** A vertical line through the middle of the view's left and right margins. */
    ALMarginAxisVertical = NSLayoutAttributeCenterXWithinMargins,
    /** A horizontal line through the middle of the view's top and bottom margins. */
    ALMarginAxisHorizontal = NSLayoutAttributeCenterYWithinMargins
};
#endif /* __PureLayout_MinBaseSDK_iOS8 */

/** A block containing method calls to the PureLayout API. Takes no arguments and has no return value. */
typedef void(^ALConstraintsBlock)(void);

#endif /* PureLayoutDefines_h */