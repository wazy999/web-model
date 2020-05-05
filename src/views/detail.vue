<template>
  <div style="background:#1a1a1a;color:white;height:100vh;">
    <el-page-header @back="goBack" :content="equipType"></el-page-header>
    <!-- 智能空调 -->
    <div v-if="equipType == '智能空调'">
      <img src="../assets/image/空调.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>
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
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>
      <echarts style="position:absolute;top:40%;" :value="waterTemp" unit="°" text="温度"></echarts>
      <div
        style="position:absolute;top:48%;left:50%;line-height:40px;text-align:left;font-size:20px"
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
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>
      <div
        style="position:absolute;top:48%;left:50%;line-height:40px;text-align:left;font-size:20px;transform:translateX(-50%)"
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
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>
      <audio :src="List.songurl" ref="audio" autoplay loop></audio>
      <img :src="List.img" alt width="300px" style="position:absolute;top:40%;left:20%" />
      <div
        style="position:absolute;top:48%;left:60%;line-height:40px;text-align:left;font-size:20px;transform:translateX(-50%)"
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
      data: "",
      equipList: "",
      equipType: "",
      introduct:
        "智能空调是具有自动调节功能的空调。智能空调系统能根据外界气候条件，按照预先设定的指标对温度、湿度、空气清洁度传感器所传来的信号进行分析、判断、及时自动打开制冷、加热、去湿及空气净化等功能的空调。适合放在卧室，客厅等地方。最低温度16摄氏，最高26，27度",
      temperature: 20,
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
    this.time = this.List.week
      ? this.List.week + ":" + this.List.startTime + "~" + this.List.endTime
      : "今天：" + this.List.startTime + "~" + this.List.endTime;
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
      return new Promise((resolve, reject) => {
        this.$axios
          .post("http://localhost:3000/room/equipmentlist", {
            name: this.$route.query.name
          })
          .then(success => {
            this.equipList = success.data.inf;
            this.List2 = this.equipList;
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