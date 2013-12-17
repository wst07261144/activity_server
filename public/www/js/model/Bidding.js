function Bidding(bid, phone) {
    this.phone = phone;
    this.price = bid;
    this.create_time3=new Date().getTime()
}

Bidding.judge_has_signed = function (bid, phone) {
    var signed
    var sign_ups_json = JSON.parse(localStorage.sign_ups)
    var new_sign_ups = _.filter(sign_ups_json, function (sign_up) {
        return sign_up.activity_id == localStorage.activity_sign_up_id
    })
    _.each(new_sign_ups, function (sign_up) {
        if (Number(sign_up.phone) == Number(phone)) {
            signed = true

        }
    })
    if(signed){
        return Bidding.judge_repeat_bid(bid, phone)
    }
    SignUp.reply_message(phone,'running3','bid')

}
Bidding.judge_repeat_bid = function (bid, phone) {
    var repeat
    var bids_json = JSON.parse(localStorage.bids)
    var new_bid_json = _.filter(bids_json, function (i_bid) {
        return i_bid.activity_id == localStorage.getItem('activity_sign_up_id') &&
            i_bid.name == localStorage.getItem('bid_sign_up_name')
    })
    _.each(new_bid_json.biddings, function (sign_up) {
        if (Number(sign_up.phone) == Number(phone)) {
            repeat = true
        }
    })
    if (!repeat) {
        return Bidding.save_bid(bid, phone)
    }
    SignUp.reply_message(phone,'running2','bid')
}
Bidding.save_bid = function (bid, phone) {
    var new_bid = new Bidding(bid, phone)
    var bids_json = JSON.parse(localStorage.bids)
    var new_bid_json = _.map(bids_json, function (i_bid) {
        if (i_bid.activity_id == localStorage.activity_sign_up_id &&
            i_bid.name == localStorage.bid_sign_up_name) {
            i_bid.biddings.push(new_bid)
        }
        return i_bid
    })
    localStorage.bids = JSON.stringify(new_bid_json)
    SignUp.reply_message(phone,'running1','bid')
    SignUp.go_to_act_detail_page_by_name_of('bid_sign_up')

}
function Winner(name,price,phone){
    this.activity_id=localStorage.current_activity_id
    this.user = localStorage.current_user
    this.bid_name = localStorage.current_bid
    this.name= name
    this.phone = phone
    this.price = price
}
Winner.prototype.create=function(){
    var winners = JSON.parse(localStorage.winners)
    winners.push(this)
    localStorage.winners=JSON.stringify(winners)
}
Bidding.render_biddings = function () {
    var unique_bid_array, name , winner = []
    var new_bidding = Bidding.add_names_for_bidding()
    unique_bid_array = Bidding.get_unique_bid_array(new_bidding)
    unique_bid_array!=""? winner.push(unique_bid_array[0].num[0]):winner.push({"name":"竞价无效","price":'',"phone":""})
    localStorage.success = unique_bid_array!=""
    var win=new Winner(winner[0].name,winner[0].price,winner[0].phone)
    win.create();
    localStorage.setItem("winner",JSON.stringify(winner))
    return winner
}
Bidding.check_bid_success=function(){
    if(localStorage.success=='true'){
        return true
    }
    else return false
}
Bidding.get_winner=function(){
    return JSON.parse(localStorage.winner)
}
Bidding.add_names_for_bidding = function () {
    var bid_json = JSON.parse(localStorage.bids)
    var new_bid_json = _.find(bid_json, function (i_bid) {
        return  i_bid.activity_id == localStorage.current_activity_id &&
            i_bid.name == localStorage.current_bid
    })
    return _.map(new_bid_json.biddings, function (bid) {
        var name_ = Bidding.find_name(bid.phone)
        bid['name'] = name_
        return bid
    })

}
Bidding.get_num=function(){
    return Bidding.add_names_for_bidding().length
}
Bidding.find_name = function (phone) {
    var sign_ups_json = JSON.parse(localStorage.sign_ups)
    var new_sign_ups = _.filter(sign_ups_json, function (sign_up) {
        return sign_up.activity_id == localStorage.current_activity_id
    })
    var find_info = _.find(new_sign_ups, function (sign_up) {
        if (Number(sign_up.phone) == Number(phone)) {
            return sign_up
        }
    })
    return find_info.name
}
Bidding.get_unique_bid_array = function (bid_info) {
    var bid_result_count = [], get_unique_bid_array = [],bid_counts=[]
    var person_bid_group_infos = _.groupBy(bid_info, function (num) {
        return Number(num.price);
    });
    _.map(person_bid_group_infos, function (value, key) {
        var temp = person_bid_group_infos[key] = value;
        bid_result_count.push({"bid": key, "num": temp})
        bid_counts.push({'bid':key,'num':temp.length})
    })
    localStorage.bid_count=JSON.stringify(bid_counts)
    _.map(bid_result_count, function (obj) {
        if (obj.num.length == 1) {
            get_unique_bid_array.push(obj);
        }
    })
    return get_unique_bid_array
}