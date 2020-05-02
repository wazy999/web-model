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
        <div>定时： {{airTime[List.time]}}</div>
        <div>电辅热： {{List.heat?"开启":"关闭"}}</div>
        <div>干燥： {{List.dry?"开启":"关闭"}}</div>
      </div>
    </div>
    <!-- 智能电灯 -->
    <div v-if="equipType == '智能电灯'">
      <img src="../assets/image/电灯.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>
      <echarts style="position:absolute;top:40%;" :value="lightness" unit="%" text="亮度"></echarts>
      <div
        style="position:absolute;top:48%;left:50%;line-height:40px;text-align:left;font-size:20px"
      >
        <div>开启状态: 开启</div>
        <div>亮度： {{lightness}}</div>
        <div>颜色：红色</div>
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
        <div>开启状态: 开启</div>
        <div>温度设置： 24°C</div>
        <div>实际温度： 制冷运行</div>
        <div>热水量： 小风</div>
        <div>高温抑菌： 关闭</div>
        <div>无电洗： 关闭</div>
        <div>预约： 关闭</div>
        <div>半胆速热： 关闭</div>
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
        <div>开启状态: 开启</div>
        <div>摄像头： 24°C</div>
        <div>语音通话： 制冷运行</div>
      </div>
    </div>
    <!-- 智能音响 -->
    <div v-if="equipType == '智能音响'">
      <img src="../assets/image/音箱.png" style="width:100px" />
      <p style="font-size:30px;font-weight:blod">—— 产品介绍 ——</p>
      <p style="margin:0 100px;text-align:left;text-indent:32px">{{introduct}}</p>
      <div
        style="position:absolute;top:48%;left:50%;line-height:40px;text-align:left;font-size:20px;transform:translateX(-50%)"
      >
        <div>开启状态: 开启</div>
        <div>模式： 音乐播放</div>
        <div>当前播放： 小风</div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import echarts from "./echart";
export default {
  components: {
    echarts
  },
  data() {
    return {
      equipType: "",
      introduct:
        "智能空调是具有自动调节功能的空调。智能空调系统能根据外界气候条件，按照预先设定的指标对温度、湿度、空气清洁度传感器所传来的信号进行分析、判断、及时自动打开制冷、加热、去湿及空气净化等功能的空调。适合放在卧室，客厅等地方。最低温度16摄氏，最高26，27度",
      temperature: 20,
      waterTemp: 20,
      lightness: 70,
      List: {},
      airMode: ["制冷模式", "制热模式", "通风模式"],
      Fspeed: ["小", "中", "大"],
      airTime: ["30分钟","1小时","2小时","3小时","4小时","5小时","6小时","7小时","8小时"]
    };
  },
  computed: {
    ...mapState(["airConList"])
  },
  mounted() {
    this.equipType = this.$route.query.equipType;
    this.airConList.forEach(item => {
      if (
        item.name == this.$route.query.name &&
        item.equipName == this.$route.query.equipName
      ) {
        this.List = item;
      }
    });
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    }
  }
};
</script>

<style>
</style>