function SignUp(name, phone) {
    this.name = name;
    this.phone = phone;
    this.create_time1 =  new Date().getTime();
    this.user = localStorage.current_user
    this.activity_id =localStorage.activity_sign_up_id;
}

SignUp.prototype.create = function () {
    var sign_up_json = JSON.parse(localStorage.sign_ups)
    sign_up_json.push(this)
    localStorage.sign_ups = JSON.stringify(sign_up_json)
}

SignUp.get_status_from_local_list=function(){
    var activities = JSON.parse(localStorage.activities)
    localStorage.activity_status_temp = activities[localStorage.current_activity_id].status
}

SignUp.get_activity_status=function(){
    return localStorage.activity_status_temp
}

SignUp.change_status_to_running=function(){
    localStorage.setItem("activity_sign_up_id",localStorage.current_activity_id)
    localStorage.setItem('yellow_activity',localStorage.activity_sign_up_id)
    localStorage.setItem("activity_status_temp","running")
}
SignUp.change_status_to_ran=function(){
    localStorage.setItem('yellow_activity','')
    localStorage.setItem("activity_status_temp","ran")
}
SignUp.make_bid_sign_up_mark=function(){
    localStorage.setItem("record_bid_sign_up_status", "before_running");
}

SignUp.save_all_activity_status = function() {
    var activities = JSON.parse(localStorage.activities)
    activities[localStorage.activity_sign_up_id].status = localStorage.activity_status_temp
    localStorage.activities=JSON.stringify(activities)
}

SignUp.judge_repeat_name = function (name, phone) {
    var repeat
    var current_sign_up = _.filter(JSON.parse(localStorage.sign_ups), function (sign_up) {
        return sign_up.activity_id == localStorage.activity_sign_up_id
    })

    _.each(current_sign_up, function (sign_up) {
        if (sign_up.phone == phone) {
            repeat = true
        }
    })

    if (!repeat) {
        return SignUp.create_activity(name, phone)
    }
    SignUp.reply_message(phone,'running2','activity')
}
SignUp.create_activity = function (name, phone) {
    new SignUp(name, phone).create()
    SignUp.reply_message(phone,'running1','activity')
    SignUp.go_to_act_detail_page_by_name_of('activity_sign_up')
}


SignUp.render_sign_ups = function () {
    var current_sign_up = _.filter(JSON.parse(localStorage.getItem('sign_ups')), function (sign_up) {
        return sign_up.activity_id == localStorage.current_activity_id
    })
    return  current_sign_up
}
SignUp.get_numbers=function(){
    return SignUp.render_sign_ups().length
}

var tip={
    "tip1":"尚有报名未结束，请先结束另一报名","tip2":"请结束活动报名后再查看竞价列表",
    'tip3':"请结束竞价后报名后在查看竞价结果"
}
var replay_activity_content={
    "before_running":"活动尚未开始，请稍后", "running1":"恭喜！报名成功",
    "running2":"您已经报名成功，请勿重复报名","ran":"Sorry，活动报名已结束"
}
var replay_bid_content={

    "before_running":"对不起，竞价尚未开始！","running1":"恭喜！您已出价成功",
    "running2":"您已经竞价成功，请勿重复出价","running3":"您未参加报名，不能竞价",
    "running4":"竞价无效，竞价价格为数字","ran":"对不起，竞价已结束！"
}

SignUp.alert_message=function(content){
    var msg=tip[content];
    alert(msg)
}
SignUp.reply_message=function(phone_number,status,selction) {
    var msg;
    selction=="activity"?msg = replay_activity_content[status]:msg = replay_bid_content[status]
    console.log(msg);
    // native_accessor.send_sms(photo_number, msg, success_callback, failed_callback);
}

SignUp.go_to_act_detail_page_by_name_of=function(act_name) {

    var page_jump_or_not = document.getElementById(act_name)
    if (page_jump_or_not) {
        var scope = angular.element(page_jump_or_not).scope();
        scope.$apply(function () {
            scope.data_refresh();
        })

    }
}
