
function BidList(bid_name,bid_status){
    this.bid_name = bid_name;
    this.bid_status = bid_status;
}

BidList.prototype.save_bid_msg=function(){
    var local_bid_list = JSON.parse(localStorage.getItem("bid_list_array" + SignUp.get_activity_id()))
    local_bid_list.unshift(this)
    localStorage.setItem("bid_list_array" + SignUp.get_activity_id(), JSON.stringify(local_bid_list))
}

BidList.get_bid_list=function(){
    return  JSON.parse(localStorage.getItem("peron_bid_index"))[SignUp.get_activity_id()]
}

BidList.save_bid_counter=function(){
    var  bid_list_counter, local_list;
    bid_list_counter = Number(BidList.get_bid_list());
    bid_list_counter++;
    local_list = JSON.parse(localStorage.getItem("peron_bid_index"));
    local_list[SignUp.get_activity_id()] = bid_list_counter;
    localStorage.setItem("peron_bid_index", JSON.stringify(local_list));
}

BidList.save_all_bid_status=function() {
    var  bid_list_id, local_list;
    bid_list_id = JSON.parse(localStorage.getItem("bid_sign_up_id"));
    localStorage.getItem("mark_of_start_bid") == "create bid" ? bid_list_id = 0 :{}
    local_list = JSON.parse(localStorage.getItem("bid_list_array" + SignUp.get_activity_id()));
    local_list[bid_list_id].bid_status = localStorage.getItem("sign_up_status_temp");
    localStorage.setItem("bid_list_array" + SignUp.get_activity_id(), JSON.stringify(local_list));
}

BidList.get_bid_activity_id=function(activity_id) {
    var _bid_id = localStorage.getItem("bid_sign_up_id");
    var bid_counter = JSON.parse(localStorage.getItem("peron_bid_index"))[activity_id];
    var bid_list_length = JSON.parse(localStorage.getItem("bid_list_array" + activity_id)).length;
    var bid_id = bid_list_length - parseInt(_bid_id);
    localStorage.getItem("mark_of_start_bid") == "create bid" ? bid_id = bid_counter : {}
    return bid_id;
}

















