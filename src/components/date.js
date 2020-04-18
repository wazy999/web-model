function getWeek(){
    const week = new Date().getDay()
    switch(week){
      case 0:
       return "星期日";
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
    } 
}
function getTime(){
    const hour = new Date().getHours() < 10?"0" + new Date().getHours():new Date().getHours();
    const minute = new Date().getMinutes() < 10?"0" + new Date().getMinutes():new Date().getMinutes();
    const second = new Date().getSeconds() < 10?"0" + new Date().getSeconds():new Date().getSeconds();
    return hour + ":" + minute + ":" + second
}
function getDate(){
    const year = new Date().getFullYear();
    const month = new Date().getMonth() - 1;
    const day = new Date().getDate();
    return year + "年" + month + "月" + day + "日"
}
export {getWeek,getTime,getDate}
