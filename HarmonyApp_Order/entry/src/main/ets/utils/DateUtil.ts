class DateUtil {

  getMs() {
    return new Date().getTime()
  }

  // 生成订单编号
  generateOrderCode() {
    var date = new Date();
    var year = date.getFullYear();
    var month = this.padZero(date.getMonth() + 1);
    var day = this.padZero(date.getDate());
    var hours = this.padZero(date.getHours());
    var minutes = this.padZero(date.getMinutes());
    var seconds = this.padZero(date.getSeconds());

    return `c${year}${month}${day}${hours}${minutes}${seconds}`;
  }

  generateDateStr() {
    return this.formatDate(new Date())
  }

  formatDate(date: Date) {
    var year = date.getFullYear();
    var month = this.padZero(date.getMonth() + 1);
    var day = this.padZero(date.getDate());
    var hours = this.padZero(date.getHours());
    var minutes = this.padZero(date.getMinutes());
    var seconds = this.padZero(date.getSeconds());

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
  }

  private padZero(num) {
    return num < 10 ? '0' + num : num;
  }
}

var dateUtil = new DateUtil()

export default dateUtil as DateUtil



