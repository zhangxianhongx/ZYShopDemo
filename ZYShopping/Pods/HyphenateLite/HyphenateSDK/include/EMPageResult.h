/*!
 *  @header EMPageResult.h
 *  @abstract Subsection result
 *  @author Hyphenate
 *  @version 3.00
 */

#import <Foundation/Foundation.h>

/*!
 *  Subsection result
 */
@interface EMPageResult : NSObject

/*!
 *  Result list<id>
 */
@property (nonatomic, strong) NSArray *list;

/*!
 *  The count of current list
 */
@property (nonatomic) NSInteger count;

/*!
 *  Get result instance
 *
 *  @param aList    Result list<id>
 *  @param aCount   The count of current list
 *
 *  @result An instance of cursor result
 */
+ (instancetype)pageResultWithList:(NSArray *)aList
                          andCount:(NSInteger)aCount;

@end
