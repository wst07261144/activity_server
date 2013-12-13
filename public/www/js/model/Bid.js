function Bid(name) {
    this.name = name;
    this.create_time2=new Date().getTime()
    this.activity_id = localStorage.current_activity_id
    this.status = 'before_running'
    this.biddings = [];
}

Bid.create_new_bid = function () {
    var current_bid = _.filter(JSON.parse(localStorage.bids), function (bid) {
        return bid.activity_id == localStorage.current_activity_id
    })
    var name = '竞价' + (Number(current_bid.length) + 1)
    localStorage.current_bid = name
    var bids_json = JSON.parse(localStorage.bids)
    bids_json.push(new Bid(name))
    localStorage.bids = JSON.stringify(bids_json)
    localStorage.setItem("bid_status_temp", "before_running");
}

Bid.save_current_bid=function(bid_name){
    localStorage.current_bid=bid_name;
}

Bid.judge_button_can_click=function(){
    return localStorage.getItem("record_bid_sign_up_status") == "running"
}

Bid.find_current_bid_status=function(){
    var bids_json=JSON.parse(localStorage.getItem('bids'))
    var bids_of_current_activity=_.filter(bids_json,function(bid_json){
        return bid_json.activity_id==localStorage.current_activity_id
    })
    var current_bid_json=_.find(bids_of_current_activity,function(bid){
        return bid.name==localStorage.current_bid
    })
    localStorage.bid_status_temp=current_bid_json.status
    return current_bid_json.status
}

Bid.change_to_running=function() {
    localStorage.setItem('yellow_bid',localStorage.activity_sign_up_id)
    localStorage.setItem("bid_sign_up_name",localStorage.current_bid)
    localStorage.setItem("bid_status_temp", "running");
    localStorage.setItem("record_bid_sign_up_status", "running");
}


Bid.make_some_mark_to_local=function(){
    localStorage.setItem('yellow_bid','')
    localStorage.setItem("bid_sign_up_name",'')
    localStorage.setItem("bid_status_temp", "ran");
    localStorage.setItem("record_bid_sign_up_status", "ran");
}
Bid.save_all_bid_status=function() {
    var bid_json = JSON.parse(localStorage.bids)
    var new_bid_json = _.filter(bid_json, function (i_bid) {
        if(i_bid.activity_id == localStorage.current_activity_id &&
            i_bid.name == localStorage.current_bid){
            i_bid.status=localStorage.getItem("bid_status_temp")
        }
        return i_bid
    })
    localStorage.bids=JSON.stringify(new_bid_json)
}
Bid.judge_bid_ran=function(){
    return Bid.find_current_bid_status()=='ran'
}


Bid.render_bids = function () {
    var bids_json = JSON.parse(localStorage.bids)
    var new_bids_json = _.filter(bids_json, function (bid) {
        return bid.activity_id == localStorage.current_activity_id
    })
    return new_bids_json
}
Bid.get_bid_count=function(){
    return JSON.parse(localStorage.getItem('bid_count'))
}