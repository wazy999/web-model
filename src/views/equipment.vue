<template>
  <div style="background:#1a1a1a;color:white;height:100vh;">
    <el-page-header @back="goBack" content="设备显示"></el-page-header>
    <el-tabs :tab-position="tabPosition" style="height: 100vh;">
      <el-tab-pane label="用户管理">
				<el-row :gutter="15">
					<el-col v-for="equip in equipList" :key="equip.id" :span="8" style="height:320px;margin:10px 0">
						<div class="smallCard">
							<span style="width:70px;height:70px;position:absolute;left:2%;top:5%">{{equip.equipName}}</span>
							<img src="../assets/image/jiadian.png" alt="" style="width:70px;height:70px;position:absolute;left:50%;top:30%;transform: translateX(-50%)">
						</div>
					</el-col>
				</el-row>
			</el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
export default {
  data() {
    return {
			tabPosition: "left",
			equipList:[],
    };
	},
	mounted(){
		this.getList()
	},
  methods: {
    goBack() {
      this.$router.go(-1);
		},
		getList(){
      this.$axios.post("http://localhost:3000/room/equipmentlist",{
					name:"sdfsdf"
			})
      .then(success=>{
				this.equipList = success.data.inf
				console.log(this.equipList)
    })
		}
	}
}
</script>

<style scoped>
.el-tabs__item{
	height: 50px!important;
	margin: 10px;
	border-radius: 5px;
	background:#262626!important;
	color:#393939!important;
	font-size: 15px!important;
	text-align: center!important;
	line-height: 50px!important;
}
.el-tabs__item.is-active{
	color: white!important;
	background:#808386!important;
}
.el-tabs__active-bar{
	visibility: hidden;
}
.el-tabs--left{
	margin-top: 50px;
}
.smallCard{
  background:#262626;
  border-radius:5px;
  height:320px;
  position:relative
}
</style>