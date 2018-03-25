Page({

  /**
   * 页面的初始数据
   */
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

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
    
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
    
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
    
  }
})