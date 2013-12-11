function SMSBid(name,phone,bid){
    this.name= name;
    this.phone= phone
    this.bid= bid;
}
SMSBid.prototype.save=function(act_id,bid_id){
   var local_bid_list = JSON.parse(localStorage.getItem("activity" + act_id + "--bid" + bid_id)) || [];
   local_bid_list.unshift(this);
   localStorage.setItem("activity" + act_id + "--bid" + bid_id, JSON.stringify(local_bid_list));
}

SMSBid.judge_bid_running=function(phone){
    localStorage.getItem("sign_up_status_temp") == "running" ? SMSBid.get_name_of_bid_sign_up(phone):
        SignUp.reply_message(phone,localStorage.getItem("sign_up_status_temp"),"bid")
}

SMSBid.get_name_of_bid_sign_up=function(phone) {
    var person_info, bid_person_name;
    person_info = JSON.parse(localStorage.getItem("person_information" + SignUp.get_activity_id()));
    if (person_info) {
        _.map(person_info, function (obj) {
            if (Number(phone) == Number(obj.phone)) {
                bid_person_name = obj.name
            }
        })
    }
    console.log(bid_person_name)
    localStorage.setItem("current_name",bid_person_name)
    bid_person_name?SMSBid.check_is_available_bid(phone):SignUp.reply_message(phone,"running3","bid")
}

SMSBid.check_is_available_bid=function(phone) {
    var check_is_repeat_bid;
    var act_id= SignUp.get_activity_id()
    var bid_id= BidList.get_bid_activity_id(act_id)
    var local_list_temp = JSON.parse(localStorage.getItem("activity" + act_id + "--bid" + bid_id));
    if (local_list_temp) {
        _.map(local_list_temp, function (obj) {
            if (Number(phone) == Number(obj.phone)) {
                check_is_repeat_bid = true
            }
        })
    }
    check_is_repeat_bid?SignUp.reply_message(phone,"running2","bid"):
        SMSBid.save_and_display(act_id,bid_id,phone)
}

SMSBid.save_and_display=function(act_id,bid_id,phone) {
    var name=localStorage.getItem("current_name")
    var bid=localStorage.getItem("current_bid")
    new SMSBid(name,phone,bid).save( act_id , bid_id)
    SignUp.go_to_act_detail_page_by_name_of("bid_sign_up_page");
    SignUp.reply_message(phone,"running1","bid");
}

