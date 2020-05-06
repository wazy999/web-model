<template>
  <div
    style="background:#1a1a1a;color:white;height:100vh;"
    v-loading="loading"
    element-loading-text="拼命加载中"
    element-loading-spinner="el-icon-loading"
    element-loading-background="rgba(0, 0, 0, 0.8)"
  >
    <el-page-header @back="goBack" :content="equipType"></el-page-header>
    <!-- 智能空调 -->
    <div v-if="equipType == '智能空调'">
      <img src="../assets/image/空调.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 美的智能空调介绍 ——</p>
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{Meidiintroduct}}</p>
      <echarts style="position:absolute;top:40%;" :value="List.temperature" unit="°C" text="温度"></echarts>
      <div
        style="position:absolute;top:48%;left:50%;line-height:40px;text-align:left;font-size:20px"
      >
        <div>开启状态: {{List.changer?"开启":"关闭"}}</div>
        <div>温度： {{List.temperature}}°C</div>
        <div>风向： {{List.sxfeng?"上下风":List.zyfeng?"左右风":"自动风"}}</div>
        <div>模式： {{airMode[List.mode]}}</div>
        <div>风速： {{Fspeed[List.speed]}}</div>
        <div>定时： {{airTime[List.time]?airTime[List.time]:"关闭"}}</div>
        <div>电辅热： {{List.heat?"开启":"关闭"}}</div>
        <div>净化： {{List.clear?"开启":"关闭"}}</div>
        <div>干燥： {{List.dry?"开启":"关闭"}}</div>
      </div>
    </div>
    <!-- 智能电灯 -->
    <div v-if="equipType == '智能电灯'">
      <img src="../assets/image/电灯.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>    
      <echarts
        style="position:absolute;top:40%;"
        :value="lightness[List.lightness]"
        unit="%"
        text="亮度"
      ></echarts>
      <div
        style="position:absolute;top:48%;left:50%;line-height:40px;text-align:left;font-size:20px"
      >
        <div>开启状态: {{List.changer?"开启":"关闭"}}</div>
        <div>模式： {{lampMode[List.mode]}}</div>
        <div>亮度： {{lightness[List.lightness]}}%</div>
        <div>颜色：{{color[List.color]}}</div>
      </div>
    </div>
    <!-- 智能热水器 -->
    <div v-if="equipType == '智能热水器'">
      <img src="../assets/image/热水器.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <video src="http://video.mdcdn.cn/ImageStore/170106/video/16ecf8a1624d8651d00d9868ba2310c4_conv.mp4" style="margin:0 100px;text-align:left;text-indent:32px;width:400px" autoplay loop controls></video>
      <echarts style="position:absolute;top:50%;left:10%" :value="List.temperature" unit="°" text="温度"></echarts>
      <div
        style="position:absolute;top:55%;left:50%;line-height:40px;text-align:left;font-size:20px"
      >
        <div>开启状态: {{List.changer?"开启":"关闭"}}</div>
        <div>温度设置： {{List.temperature}}°</div>
        <div>热水量： 100%</div>
        <div>高温抑菌：{{List.highTem?"开启":"关闭"}}</div>
        <div>无电洗： {{List.noEletri?"开启":"关闭"}}</div>
        <div>e+增容： {{List.ezeng?"开启":"关闭"}}</div>
        <div>云管家： {{List.cloud?"开启":"关闭"}}</div>
        <div>预约： {{time?time:"关闭"}}</div>
        <div>半胆速热： {{List.fastHeat?"开启":"关闭"}}</div>
      </div>
    </div>
    <!-- 智能门锁 -->
    <div v-if="equipType == '智能门锁'">
      <img src="../assets/image/智能门锁.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <video src="http://cloud.video.taobao.com/play/u/2200777838130/p/1/e/6/t/1/259844259372.mp4" style="margin:0 100px;text-align:left;text-indent:32px;width:400px" autoplay loop controls></video>

      <div
        style="position:absolute;top:60%;left:50%;line-height:40px;text-align:left;font-size:20px;transform:translateX(-50%)"
      >
        <div>开启状态: {{List.changer?"开启":"关闭"}}</div>
        <div>摄像头： {{List.camera?"开启":"关闭"}}</div>
        <div>语音通话： {{List.sound?"开启":"关闭"}}</div>
      </div>
    </div>
    <!-- 智能音响 -->
    <div v-if="equipType == '智能音响'">
      <img src="../assets/image/音箱.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <video src="https://product-online.cdn.bcebos.com/1587374553397854.mp4" style="margin:0 100px;text-align:left;text-indent:32px;width:400px" autoplay loop controls></video>
      <audio :src="List.songurl" ref="audio" autoplay loop></audio>
      <img :src="List.img" alt width="200px" style="position:absolute;top:60%;left:30%" />
      <div
        style="position:absolute;top:60%;left:60%;line-height:40px;text-align:left;font-size:20px;transform:translateX(-50%)"
      >
        <div>开启状态: {{List.changer?"开启":"关闭"}}</div>
        <div>模式： {{List.child?"儿童模式":musicMode[List.mode]}}</div>
        <div>当前播放：{{List.songName}}</div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import echarts from "./echart";
export default {
  components: {
    echarts
  },
  data() {
    return {
      time: "",
      loading:true,
      data: "",
      equipList: "",
      equipType: "",
      temperature: 20,
       introduct:
      "智能灯泡，是新的灯泡产品形式。采用嵌入式物联网核心技术，将互通核心模块嵌入到节能灯泡。互联网无处不在的催生，随时随地的互通、互动的时代特征影响到节能灯泡产品的发展和演变，以led照明灯泡设计为主流，同时充分体现节能化、健康化、艺术化和人性化的照明发展趋势，成为居室灯光文化的主导。",
      Meidiintroduct:
      "美的智能空调是具有自动调节功能的空调。智能空调系统能根据外界气候条件，按照预先设定的指标对温度、湿度、空气清洁度传感器所传来的信号进行分析、判断、及时自动打开制冷、加热、去湿及空气净化等功能的空调。适合放在卧室，客厅等地方。最低温度16摄氏，最高26，27度",
      waterTemp: 20,
      List: {},
      List2: [],
      airMode: ["制冷模式", "制热模式", "通风模式"],
      Fspeed: ["小", "中", "大"],
      musicMode: ["播放音乐", "收音机", "智能助手"],
      airTime: [
        "30分钟",
        "1小时",
        "2小时",
        "3小时",
        "4小时",
        "5小时",
        "6小时",
        "7小时",
        "8小时"
      ],
      color: ["黄色", "白色", "红色", "青色"],
      lightness: [10, 30, 50, 70, 80, 90, 100],
      lampMode: ["护眼模式", "普通模式", "睡眠模式"]
    };
  },
  computed: {
    ...mapState(["airConList"])
  },
  mounted() {
    this.$nextTick(() => {
      if (this.List.play && this.List.changer) {
        this.$refs.audio.play();
      } else {
        this.$refs.audio.pause();
      }
      const play = setInterval(() => {
        if (this.List.play && this.List.changer) {
          this.$refs.audio.play();
        } else {
          this.$refs.audio.pause();
        }
      }, 2000);
    });
    this.getList().then(() => {
      this.getValue();
    });
    this.equipType = this.$route.query.equipType;
    this.airForeach();
    console.log(this.airConList, "this.airConList");
    this.time = this.List.startTime?this.List.week
      ? this.List.week + ":" + this.List.startTime + "~" + this.List.endTime
      : "今天：" + this.List.startTime + "~" + this.List.endTime:"关闭";
  },
  methods: {
    ...mapMutations(["getAllList"]),
    airForeach() {
      this.airConList.forEach(item => {
        if (
          item.name == this.$route.query.name &&
          item.equipName == this.$route.query.equipName
        ) {
          this.List = item;
          if (this.List.temperature) {
            this.temperature = this.List.temperature;
          }
        }
      });
    },
    getList() {
      this.loading = true
      return new Promise((resolve, reject) => {
        this.$axios
          .post("http://localhost:3000/room/equipmentlist", {
            name: this.$route.query.name
          })
          .then(success => {
            this.equipList = success.data.inf;
            this.List2 = this.equipList;
            this.loading = false
            resolve();
          });
      });
    },
    getValue() {
      if (window.WebSocket) {
        const ws = new WebSocket("ws://localhost:8081");
        ws.onopen = message => {
          console.log("连接服务器成功" + message);
          ws.send(this.$route.query.name); 
        };
        ws.onmessage = mes => {
           this.loading = true
          console.log("接受消息", JSON.parse(mes.data));
          this.data = JSON.parse(mes.data);
          console.log(this.data, this.equipList, "this.equipList");
          this.equipList.forEach((item, index) => {
            this.data.forEach(element => {
              if (element.equipName == item.equipName) {
                this.$set(this.List2, index, Object.assign({}, item, element));
              }
            });
          });
          this.getAllList(this.List2);
          this.airForeach();
           this.loading = false
        };
        ws.onclose = function() {
          console.log("连接已关闭...");
        };
      } else {
        console.log("连接服务器失败");
      }
    },
    goBack() {
      this.$router.go(-1);
    }
  }
};
</script>

<style>
</style>