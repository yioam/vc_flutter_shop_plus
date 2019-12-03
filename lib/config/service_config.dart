const serviceUrl = 'http://v.jspang.com:8088/baixing';

const servicePath = <String, String>{
  'homePageContent': serviceUrl + '/wxmini/homePageContent', // 首页主要内容信
  'homePageBelowConten': serviceUrl + '/wxmini/homePageBelowConten', // 首页火爆专区
  'getCategory': serviceUrl + '/wxmini/getCategory', // 商品类别
  'getMallGoods': serviceUrl + '/wxmini/getMallGoods', // 商品分类的商品列表
  'getGoodDetailById': serviceUrl + '/wxmini/getGoodDetailById' // 商品详细信息
};
