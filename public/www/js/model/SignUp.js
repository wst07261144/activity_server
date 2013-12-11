function SignUp(name,phone){
    this.name = name;
    this.phone = phone;
}

SignUp.prototype.save_sign_up_information=function() {
    var local_activity_list = JSON.parse(localStorage.getItem("person_information"+SignUp.get_activity_id()));
    local_activity_list.unshift(this);
    localStorage.setItem("person_information"+SignUp.get_activity_id(), JSON.stringify(local_activity_list));
}

SignUp.refresh_and_reply_message=function(phone_number){
    SignUp.go_to_act_detail_page_by_name_of("jump");
    SignUp.reply_message(phone_number,"running1","activity");
}

SignUp.inti=function(id){
    localStorage.getItem("person_information"+id)?{}:localStorage.setItem("person_information"+id,'[]')
}

SignUp.activity_sign_up_inti=function(){
    var id = JSON.parse(localStorage.getItem("sign_up_id"));
    if (localStorage.getItem("mark_of_create_activity") == "") {
        var local_list_temp = JSON.parse(localStorage.getItem("event_name"));
        localStorage.setItem("activity_status_temp", local_list_temp[id].activity_status);
    }
}

SignUp.numbers=function(id) {
    if (JSON.parse(localStorage.getItem("person_information" + id))) {
        return JSON.parse(localStorage.getItem("person_information" + id)).length;
    }
}

SignUp.get_showed_info=function() {
    return JSON.parse(localStorage.getItem("person_information" +  SignUp.get_activity_id()));
}

SignUp.get_activity_status=function(){
    return localStorage.getItem("activity_status_temp")

}

SignUp.get_activity_sign_up_inf=function(id){
    return localStorage.getItem("person_information" +id)
}

SignUp.change_status_to_running=function(){
    localStorage.setItem("activity_status_temp","running")
}
SignUp.change_status_to_ran=function(){
    localStorage.setItem("activity_status_temp","ran")
}

SignUp.make_bid_sign_up_mark=function(){
    localStorage.setItem("record_bid_sign_up_status", "before_running");
}

SignUp.save_all_activity_status = function() {
    var activity_list_id, id;
    id = JSON.parse(localStorage.getItem("sign_up_id"));
    localStorage.getItem("mark_of_create_activity") == "" ? activity_list_id = id : activity_list_id = 0;
    var local_list = JSON.parse(localStorage.getItem("event_name"));
    local_list[activity_list_id].activity_status = localStorage.getItem("activity_status_temp");
    localStorage.setItem("event_name", JSON.stringify(local_list));
}

SignUp.get_activity_id= function(){
    var activity_id;
    var _activity_id = localStorage.getItem("sign_up_id");
    var activity_counter = localStorage.getItem("counter of activity_list");
    var activity_list_length = JSON.parse(localStorage.getItem("event_name")).length;
    var activity_id_temp = activity_list_length - 1 - parseInt(_activity_id);
    localStorage.getItem("mark_of_create_activity") == "" ? activity_id = activity_id_temp : activity_id = activity_counter
    return activity_id;
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
    "running2":"您已经报名成功，请勿重复出价","running3":"您未参加报名，不能竞价",
    "ran":"对不起，竞价已结束！"
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