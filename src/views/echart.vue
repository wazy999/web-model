<template>
  <div>
    <div id="Chart" style="width: 600px;height:400px;"></div>
  </div>
</template>

<script>
import "echarts-liquidfill";
export default {
  props: {
    value: {
      default: 24,
      type: Number
    },
    text:{
      default:"",
      type: String
    },
    unit:String,

  },
  data() {
    return {
      a:"",
    };
  },
  mounted() {
    this.a = setInterval(()=>{
       this.drawCir();
    },1000)
  },
  updated(){
    console.log(this.value,"value")
  },
  destroyed(){
    clearInterval(this.a)
  },
  methods: {
    drawCir() {
      const value1 = (this.value * this.value * this.value) / 200;
      const myChart = this.$echarts.init(document.getElementById("Chart"));
      let option = "";
       option = {
        // backgroundColor: "#000",
        tooltip: {
          trigger: "item"
        },
        graphic: [
          {
            type: "text",
            left: "45%",
            top: "38%",
            style: {
              text: this.value + this.unit,
              fill: "#00D6CE",
              fontSize: 40
            }
          },
          {
            type: "text",
            left: "45%",
            top: "53%",
            style: {
              text: this.text,
              fill: "#fff",
              font: 'normal 1.8em "Microsoft YaHei", sans-serif'
            }
          }
        ],
        series: [
          {
            name: "",
            type: "gauge",
            radius: "60%",
            center: ["50%", "50%"],
            startAngle: 0,
            endAngle: 359.9,
            splitNumber: 90,
            hoverAnimation: true,
            axisTick: {
              show: false
            },
            splitLine: {
              length: 50,
              lineStyle: {
                width: 5,
                color: "#1a1a1a"
              }
            },
            axisLabel: {
              show: false
            },
            pointer: {
              show: false
            },
            axisLine: {
              lineStyle: {
                opacity: 0
              }
            },
            detail: {
              show: false
            },
            data: [
              {
                value: 0,
                name: ""
              }
            ]
          },
          {
            name: "",
            type: "pie",
            radius: ["45%", "51%"],
            center: ["50%", "50%"],
            silent: true,
            z: 0,
            zlevel: 0,
            label: {
              normal: {
                show: false,
                position: "center"
              }
            },
            data: [
              {
                value: 60.5,
                name: "",
                label: {
                  normal: {
                    show: false
                  }
                },
                itemStyle: {
                  normal: {
                    color: "#08A0E2"
                  }
                }
              },
              {
                value: 90.6,
                name: "",
                label: {
                  normal: {
                    show: false
                  }
                },
                itemStyle: {
                  normal: {
                    color: "#05D3CB"
                  }
                }
              },
              {
                value: value1,
                name: "",
                label: {
                  normal: {
                    show: false
                  }
                },
                itemStyle: {
                  normal: {
                    color: "yellow"
                  }
                }
              }
            ]
          }
        ]
      };
      myChart.setOption(option);
    }
  }
};
</script>

<style>
</style>