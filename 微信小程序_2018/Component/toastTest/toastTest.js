// Component/toastTest/toastTest.js
Component({

  externalClasses: ['myclass'],
  /**
   *  在组件中使用多个slot
   */
  options: {
    multipleSlots: true
  },

  /**
   * 组件的属性列表
   */
  properties: {
    inputPlaceHalder: {

      type: String,

      value: ' ',

    },
    inputHidden: {

      type: Boolean,

      value: true

    },


    dialogHidden: {

      type: Boolean,

      value: true

    },


    // 这里定义了innerText属性，属性值可以在组件使用时指定

    titleText: {

      type: String,

      value: '提示',

    },

    titleMsg: {

      type: String,

      value: ' ',

    },



    inputMsg: {

      type: String,

      value: '请输入你他妈想干嘛',

    },

    //确定

    determineBtn: {

      type: String,

      value: 'default value',

    },

    //取消

    cancleBtn: {

      type: Boolean,

      value: true,

    },

  },

  /**
   * 组件的初始数据
   */
  data: {
    inputValue: "",

    onCancleClick: false,
  },

  /**
   * 组件的方法列表
   */
  methods: {

    // 输入值

    bindKeyInput: function (e) {

      this.setData({

        inputValue: e.detail.value

      })
    },
    // 这里是一个自定义方法,取消

    cancleBtn: function () {

      // Properties pro = new Properties();

      console.log("点击取消按钮")

      this.setData({

        dialogHidden: true,

      })


    },


    // 确定

    determineBtn: function () {


      var determineDetail =
        this.data.inputValue // detail对象，提供给事件监听函数

      this.triggerEvent('determineevent', determineDetail)

      this.setData({

        inputValue: ""

      })

    }

  }
})
