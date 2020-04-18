<template>
  <div style="background:#1a1a1a;color:white;height:100vh;">
    <el-row class="header" >
      <el-col class="time" :span="11">{{time}}</el-col>
      <el-col class="date" :span="5">{{date}}</el-col>
      <el-col class="week" :span="5">{{week}}</el-col>
    </el-row>
     <el-row :gutter="5" class="content">
         <el-col :span="5"><div class="iconfont icon-tianqi- " style="font-size:80px"></div><span style="font-size:40px;color: gray;">{{weatherinfo.temp}}℃</span></el-col>
         <el-col :span="5"><div class="iconfont icon-shidu " style="font-size:80px"></div> <span class="param">相对湿度<br>{{weatherinfo.SD}}</span></el-col>
         <el-col :span="6"><div class="iconfont icon-qiya " style="font-size:80px" ></div><span class="param">气压<br>{{weatherinfo.AP}}</span></el-col>
         <el-col :span="5"><div class="iconfont icon-fengsu " style="font-size:80px"></div><span class="param">{{weatherinfo.WD}}<br>{{weatherinfo.sm}}级</span></el-col>
     </el-row>
     <el-row class="roomCard" :gutter="15">
       <el-col :span="6" v-for="(item,id) in roomList" :key="id" style="height:180px;margin:10px 0">
         <div class="smallCard" @click="tapEquip">
           <img src="../assets/image/jiadian.png" style="width:70px;height:70px;position:absolute;left:8%;top:30%" mode="" />
           <span style="position:absolute;left:10%;bottom:10px">{{item.roomName}}</span>
         </div>
         </el-col>
     </el-row>
  </div>
</template>

<script>
import {getWeek,getTime,getDate} from "../components/date"
export default {
  data(){
    return{
      date:getDate(),
      week:getWeek(),
      time:getTime(),
      wet:"70%",
      pollution:11,
      limit:'2.7',
      weatherinfo:{temp:'',SD:'',AP:"",WD:"",sm:""},
      roomList:[]
    }
  },
  mounted(){
    this.getWeather()
    this.getList()
    // const vm = this;
    const getCurTime = setInterval(() => {
      this.time = getTime()
    },1000)
    // clearInterval(getCurTime)
  },
  methods:{
    tapEquip(){
      this.$router.push("/equipment")
    },
    getWeather(){
      this.$axios.get("http://localhost:3000/weather",{
        params:{
          num:101280101
        }
      })
      .then(success=>{
        this.weatherinfo = success.data.inf.weatherinfo
      })
    },
    getList(){
       this.$axios.post("http://localhost:3000/room/roomlist")
      .then(success=>{
        this.roomList = success.data.inf
      })
    }
  }
}
</script>

<style>
  .param{
    font-size:20px;
    text-align:center;
    color: gray;
  }
  .header{
    text-align: left;
    margin: 0;
    padding: 50px;
  }
  .time{
    font-size: 100px;
  }
  .date,.week{
    font-size: 25px;
    color:gray;
    margin-top:20px
  }
  .content{
    position: absolute;
    top:0;
  }
  .roomCard{
    width: 100%;
    position: absolute;
    top: 2%;
  }
  .smallCard{
    background:#262626;
    border-radius:5px;
    height:180px;
    position:relative
  }
  .smallCard:active{
     background:#949597;
  }
  .icon{
    font-size:40px;
  }
</style>