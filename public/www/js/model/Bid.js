function Bid(){
}
Bid.init_bid_list=function(activity_id){
    localStorage.setItem("bid_list_array"+activity_id,'[]')
}
Bid.init=function(activity_id,bid_id){
    localStorage.getItem("activity"+activity_id+"--bid"+bid_id)?{}:localStorage.setItem("person_information"+id,'[]')
}

Bid.judge_button_can_click=function(){
    return localStorage.getItem("record_bid_sign_up_status") == "running"
}
Bid.judge_bid_ran=function(){
    return localStorage.getItem("sign_up_status_temp") == "ran"
}
Bid.get_showed_info=function(){
    var activity_id = SignUp.get_activity_id()
    return JSON.parse(localStorage.getItem("bid_list_array" + activity_id))
}
Bid.number=function() {
    var activity_id, bid_id;
    activity_id = SignUp.get_activity_id();
    bid_id = BidList.get_bid_activity_id(activity_id);
    if (JSON.parse(localStorage.getItem("activity" + activity_id + "--bid" + bid_id))) {
        return JSON.parse(localStorage.getItem("activity" + activity_id + "--bid" + bid_id)).length;
    }
}
Bid.get_showed_information=function(){
    var activity_id = SignUp.get_activity_id();
    var bid_id = BidList.get_bid_activity_id(activity_id);
    return JSON.parse(localStorage.getItem("activity" + activity_id + "--bid" + bid_id));
}

Bid.save_bid_info_and_process=function(){
    BidList.save_bid_counter()
    new BidList("竞价"+BidList.get_bid_list(),"before_running").save_bid_msg();
    Bid.make_some_create_marks()
}
Bid.make_some_create_marks=function(){

    localStorage.setItem("mark_of_start_bid", "create bid");
    localStorage.setItem("sign_up_status_temp", "before_running");
}
Bid.make_some_scan_marks=function(id){

    localStorage.setItem("bid_sign_up_id", id);
    localStorage.setItem("mark_of_start_bid", "");
}
Bid.judge_is_bid_running=function(){
    return localStorage.getItem("check_bid_is_start") == "running"
}
Bid.remove_mark=function(){
    localStorage.setItem("current_activity","undefined")
}

Bid.make_marks_for_before_running=function() {
    localStorage.setItem("current_activity",SignUp.get_activity_id())
    localStorage.setItem("sign_up_status_temp", "running");
    localStorage.setItem("record_bid_sign_up_status", "running");
}

Bid.page_inti=function(){
    var status, activity_id, bid_id, _bid_id;
    _bid_id = localStorage.getItem("bid_sign_up_id");
    activity_id = SignUp.get_activity_id();
    if (localStorage.getItem("mark_of_start_bid") == "") {
        status = JSON.parse(localStorage.getItem("bid_list_array" + activity_id))[_bid_id].bid_status;
        localStorage.setItem("sign_up_status_temp", status);
    }
}
Bid.make_some_mark_to_local=function(){
    localStorage.setItem("sign_up_status_temp", "ran");
    localStorage.setItem("record_bid_sign_up_status", "ran");
}

Bid.is_success_and_winner=function(save_bid_information){
    var is_success_and_winner=[],winner_temp;
    var bid_result_count=[],get_unique_bid_array=[],person_bid_group_infos;
    person_bid_group_infos = _.groupBy(save_bid_information,function(num){
        return Number(num.bid);
    });
    _.map(person_bid_group_infos, function(value,key){
        var temp=person_bid_group_infos[key]=value;
        bid_result_count.push({"bid":key,"num":temp});})
    _.map(bid_result_count,function(obj){
        if(obj.num.length==1){
            get_unique_bid_array.push(obj);
        }
    })
    get_unique_bid_array!=""? winner_temp=get_unique_bid_array[0].num[0]:winner_temp={"name":"竞价无效","bid":"","phone":""}
    localStorage.setItem("winner_info",JSON.stringify(winner_temp))
    return  winner_temp
}
Bid.check_bid_success=function(){
    var winner= Bid.is_success_and_winner(Bid.get_showed_information())
    return winner.name!="竞价无效"
}
Bid.get_bid_count=function(){
    var person_bid_infos = _.groupBy(Bid.get_showed_information(), function (num) {
        return Number(num.bid);
    });
    var bid_result_count = [];
    _.map(person_bid_infos, function (value, key) {
        bid_result_count.push({"bid": key, "num": value.length});
    })
    return bid_result_count
}
Bid.get_winner=function(){
    return JSON.parse(localStorage.getItem("winner_info"))
}
