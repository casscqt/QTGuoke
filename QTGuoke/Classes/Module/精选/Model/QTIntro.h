//
//  QTIntro.h
//  QTGuoke
//
//  Created by Cass on 15/12/10.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTIntro : NSObject


//"category": "science",
//"link_v2_sync_img": "http://jingxuan.guokr.com/pick/v2/16844/sync/",
//"source_name": "心事鉴定组",
//"title": "科学研究表明：信鸡汤的人，认知能力更差",
//"page_source": "http://jingxuan.guokr.com/pick/16844/?ad=1",
//"images": [
//           "http://2.im.guokr.com/dMSnlB-PxHcivuvirn0bu6zEJM11vVoHIc8171d0ZvYtAwAAXgMAAFBO.png?imageView2/1/w/555/h/588",
//           "http://1.im.guokr.com/61uPMqjPSAmENeZpEBRPQwoatAv7WfojRyrTXd3QF2ogAwAAEgIAAEpQ.jpg?imageView2/1/w/555/h/367"
//           ],
//"author": "Roberto A. Ferdman",
//"date_picked": 1449532851,
//"reply_root_id": 440982,
//"summary": "（Stellasun/编译）语言拥有鼓舞人心的力量，就算是含混不清、故弄玄虚、看似深刻但毫无意义的语",
//"source": "minisite",
//"is_top": false,
//"date_created": 1449212236,
//"link": "http://jingxuan.guokr.com/pick/16844/",
//"link_v2": "http://jingxuan.guokr.com/pick/v2/16844/",
//"headline_img": "http://3.im.guokr.com/HQHShpn23NLtfSRBJieP3oKCvDN772cctf_QtKJCpplKAQAA5gAAAEpQ.jpg",
//"replies_count": 11,
//"headline_img_tb": "http://3.im.guokr.com/HQHShpn23NLtfSRBJieP3oKCvDN772cctf_QtKJCpplKAQAA5gAAAEpQ.jpg?imageView2/1/w/288/h/200",
//"id": 16844

@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *link_v2_sync_img;
@property (nonatomic,copy) NSString *source_name;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *page_source;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *date_picked;
@property (nonatomic,copy) NSString *reply_root_id;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,assign) BOOL is_top;
@property (nonatomic,copy) NSString *date_created;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *link_v2;
@property (nonatomic,copy) NSString *headline_img;
@property (nonatomic,copy) NSString *replies_count;
@property (nonatomic,copy) NSString *headline_img_tb;
@property (nonatomic,copy) NSString *id;




@end
