<template>
  <div style="background:#1a1a1a;color:white;height:100vh;">
    <el-page-header @back="goBack" content="设备显示"></el-page-header>
    <el-tabs
      :tab-position="tabPosition"
      style="height: 100vh;"
      @tab-click="tabClick"
      :value="tabValue"
    >
      <el-tab-pane
        :label="item.roomName"
        :name="item.roomName"
        v-for="item in roomList"
        :key="item.id"
      >
        <el-row :gutter="15">
          <el-col
            v-for="equip in List"
            :key="equip.id"
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
                <div>温度:{{equip.temperature}}</div>
                <div>模式:{{airMode[equip.mode]}}</div>
                <div>风速:{{speed[equip.speed]}}</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能电灯'" @click="tapDetail(equip)">
              <el-switch
                v-model="value"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/电灯.png" class="imgStyle" />
              <div class="textStyle">
                <div>亮度</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能热水器'" @click="tapDetail(equip)">
              <el-switch
                v-model="value"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/热水器.png" class="imgStyle" />
              <div class="textStyle">
                <div>温度设置</div>
                <div>实际温度</div>
                <div>预约时间</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能门锁'" @click="tapDetail(equip)">
              <el-switch
                v-model="value"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/智能门锁.png" class="imgStyle" />
              <div class="textStyle">
                <div>摄像头</div>
                <div>语音通话</div>
              </div>
            </div>
            <div class="Card" v-if="equip.seleVal == '智能音响'" @click="tapDetail(equip)">
              <el-switch
                v-model="value"
                active-color="#13ce66"
                inactive-color="gray"
                :disabled="true"
              ></el-switch>
              <span class="equipName">{{equip.equipName}}</span>
              <img src="../assets/image/音箱.png" class="imgStyle" />
              <div class="textStyle">
                <div>当前模式</div>
                <div>当前播放</div>
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
      equipList: [],
      roomList: [],
      List:[],
      value: false,
      tabValue: "",
      receiveVal: [],
      airMode: ["制冷模式", "制热模式", "通风模式"],
      speed: ["小", "中", "大"],
    };
  },
  computed: {
    ...mapState(["airConList"])
  },
  mounted() {
    this.getList().then(()=>{
      this.getValue();
    }
    );
    this.getroomList();
    this.tabValue = this.$route.query.roomName;
  },
  updated(){
    console.log(this.equipList,"thisequipList")
  },
  methods: {
    ...mapMutations(["getlist"]),
    getValue(){
      if (window.WebSocket) {
        const ws = new WebSocket("ws://localhost:8081");
        ws.onopen = message => {
          console.log("连接服务器成功" + message);
          ws.send(this.tabValue);
        };
        ws.onmessage = mes => {
          console.log(JSON.parse(mes.data));
          this.getlist(JSON.parse(mes.data));
          this.equipList.forEach((item,index) => {
            this.airConList.forEach(element => {
              if(element.equipName == item.equipName){
                this.equipList[index] = {...element,...item}
              }
            })
          });
          this.List = this.equipList
          console.log(this.equipList,"equipList")
        };
        ws.onclose = function() {
          console.log("连接已关闭...");
        };
      } else {
        console.log("连接服务器失败");
      }
    },
    tabClick(e) {
      console.log(e);
      this.$router.push({ path: "/equipment", query: { roomName: e.label } });
      this.getList();
    },
    tapDetail(e) {
      this.$router.push({ path: "/detail", query: { equipType: e.seleVal,name:e.name,equipName:e.equipName} });
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
      return new Promise((resolve, reject)=> {
        this.$axios
          .post("http://localhost:3000/room/equipmentlist", {
            name: this.$route.query.roomName
          })
          .then(success => {
            this.equipList = success.data.inf;
            resolve();
            console.log(this.equipList);
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