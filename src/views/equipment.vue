<template>
  <div style="background:#1a1a1a;color:white;height:100vh;">
    <el-page-header @back="goBack" content="设备显示"></el-page-header>
    <el-tabs
      :tab-position="tabPosition"
      style="height: 100vh;"
      @tab-click="tabClick"
      :value="tabValue "
      v-loading="loading"
      element-loading-text="拼命加载中"
      element-loading-spinner="el-icon-loading"
      element-loading-background="rgba(0, 0, 0, 0.8)"
    >
      <el-tab-pane
        :label="item.roomName"
        :name="item.roomName"
        v-for="item in roomList"
        :key="item.id "
      >
        <el-row :gutter="15">
          <el-col
            v-for="equip in airConList"
            :key="equip.equipName "
            :span="8"
            style="height:320px;margin:10px 0"
          >
            <div class="Card" v-if="equip.seleVal == '智能空调'" @click="tapDetail(equip)">
              <el-switch
                :value="equip.changer?true:false"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/空调.png" class="imgStyle" />
              <div class="textStyle">
                <div>温度:{{equip.temperature}}°C</div>
                <div>模式:{{airMode[equip.mode]}}</div>
                <div>风速:{{speed[equip.speed]}}</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能电灯'" @click="tapDetail(equip)">
              <el-switch
                :value="equip.changer?true:false"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/电灯.png" class="imgStyle" />
              <div class="textStyle">
                <div>亮度:{{lightness[equip.lightness]}}%</div>
                <div>颜色:{{color[equip.color]}}</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能热水器'" @click="tapDetail(equip)">
              <el-switch
                :value="equip.changer?true:false"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/热水器.png" class="imgStyle" />
              <div class="textStyle">
                <div>温度设置:{{equip.temperature}}°</div>
                <div>高温抑菌:{{equip.highTem?"开启":"关闭"}}</div>
                <div>预约时间：{{equip.startTime?equip.week?equip.week+":"+equip.startTime+"~"+equip.endTime:'今天'+":"+equip.startTime+"~"+equip.endTime:"关闭"}}</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能门锁'" @click="tapDetail(equip)">
              <el-switch
                :value="equip.changer?true:false"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/智能门锁.png" class="imgStyle" />
              <div class="textStyle">
                <div>摄像头:{{equip.camera?"开启":"关闭"}}</div>
                <div>语音通话：{{equip.sound?"开启":"关闭"}}</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能音响'" @click="tapDetail(equip)">
              <el-switch
                :value="equip.changer?true:false"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/音箱.png" class="imgStyle" />
              <div class="textStyle">
                <div>当前模式：{{equip.child?"儿童模式":musicMode[equip.mode]}}</div>
                <div>当前播放：{{equip.songName}}</div>
              </div>
            </div>
          </el-col>
        </el-row>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { mapMutations, mapState } from "vuex";
export default {
  data() {
    return {
      tabPosition: "left",
      loading: true,
      equipList: [],
      roomList: [],
      List: [],
      value: false,
      tabValue: "",
      receiveVal: [],
      airMode: ["制冷模式", "制热模式", "通风模式"],
      speed: ["小", "中", "大"],
      data: [],
      musicMode: ["播放音乐", "收音机", "智能助手"],
      color: ["黄色", "白色", "红色", "青色"],
      lightness: [10, 30, 50, 70, 80, 90, 100],
      lampMode: ["护眼模式", "普通模式", "睡眠模式"]
    };
  },
  computed: {
    ...mapState(["airConList"])
  },
  mounted() {
    this.getList().then(() => {
      this.getValue();
    });
    this.getroomList();
    this.tabValue = this.$route.query.roomName;
  },
  methods: {
    ...mapMutations(["getAllList"]),
    getValue() {
      this.loading = true;
      if (window.WebSocket) {
        const ws = new WebSocket("ws://localhost:8081");
        ws.onopen = message => {
          console.log("连接服务器成功" + message);
          ws.send(this.tabValue);
        };
        ws.onmessage = mes => {
          console.log("接受消息", JSON.parse(mes.data));
          this.data = JSON.parse(mes.data);
          this.equipList.forEach((item, index) => {
            this.data.forEach(element => {
              if (element.equipName == item.equipName) {
                this.$set(this.List, index, Object.assign({}, item, element));
              }
            });
          });
          this.getAllList(this.List);
          this.loading = false;
        };
        ws.onclose = function() {
          console.log("连接已关闭...");
        };
      } else {
        console.log("连接服务器失败");
      }
    },
    tabClick(e) {
      console.log(e, "e");
      this.$router.push({ path: "/equipment", query: { roomName: e.label } });
      this.getList().then(() => {
        this.tabValue = this.$route.query.roomName;
        this.getValue();
      });
    },
    tapDetail(e) {
      this.$router.push({
        path: "/detail",
        query: { equipType: e.seleVal, name: e.name, equipName: e.equipName }
      });
      console.log("aa");
    },
    goBack() {
      this.$router.push({ path: "/home" });
    },
    getroomList() {
      this.$axios.post("http://localhost:3000/room/roomlist").then(success => {
        this.roomList = success.data.inf;
      });
    },
    getList() {
      return new Promise((resolve, reject) => {
        this.$axios
          .post("http://localhost:3000/room/equipmentlist", {
            name: this.$route.query.roomName
          })
          .then(success => {
            this.equipList = success.data.inf;
            this.List = this.equipList;
            resolve();
          });
      });
    }
  }
};
</script>

<style>
.el-tabs,
.el-tabs--left {
  height: 90vh !important;
}
.el-switch__core {
  left: 90px;
  top: 20px;
}
.textStyle {
  position: absolute;
  top: 60%;
  left: 100px;
  line-height: 30px;
  text-align: left;
}
.equipName {
  width: 70px;
  height: 70px;
  position: absolute;
  left: 2%;
  top: 5%;
}
.imgStyle {
  height: 70px;
  position: absolute;
  left: 50%;
  top: 25%;
  transform: translateX(-50%);
}
.el-tabs__item {
  height: 50px !important;
  margin: 10px;
  border-radius: 5px;
  background: #262626 !important;
  color: #393939 !important;
  font-size: 15px !important;
  text-align: center !important;
  line-height: 50px !important;
}
.el-tabs__item.is-active {
  color: white !important;
  background: #808386 !important;
}
.el-tabs__active-bar {
  visibility: hidden;
}
.el-tabs--left {
  margin-top: 50px;
}
.Card {
  background: #262626;
  border-radius: 5px;
  height: 320px;
  position: relative;
}
</style>