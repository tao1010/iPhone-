// pages/home/home.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {

  },

  /**
   * 组件的初始数据
   */
  data: {

    indicatorDots: true,
    autoplay: true,
    interval: 3000,
    duration: 1000,

    loadingHidden: false, // loading
    userInfo: {},
    swiperCurrent: 0,
    selectCurrent: 0,
    scrollTop: "0",
    loadingMoreHidden: true,

    hasNoCoupons: true,
    banners: [{ "image": "../../images/home/jxwc_campus_banner@2x.png", "bannerId": "1" },
      { "image": "../../images/home/jxwc_campus_banner@2x.png", "bannerId": "2" },
      { "image": "../../images/home/jxwc_campus_banner@2x.png", "bannerId": "3" }],
  },

  /**
   * 组件的方法列表
   */
  methods: {

  },
  //事件处理函数
  swiperchange: function (e) {
    console.log(e.detail.current)
  },
  tapBanner: function (e) {
   
  },
})
