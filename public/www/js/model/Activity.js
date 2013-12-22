function Activity(activity_name){
    this.id=localStorage.activity_id_generator;
    this.name=activity_name;
    this.create_time =  new Date().getTime()
    this.user=localStorage.current_user
    this.status = 'before_running'
}

Activity.prototype.create=function(){
    var activities_json=JSON.parse(localStorage.getItem('activities'))
    activities_json.push(this)
    localStorage.activities=JSON.stringify(activities_json)
    localStorage.current_activity_id= localStorage.activity_id_generator
    localStorage.current_activity = this.name
    var id=Number(localStorage.activity_id_generator)+1
    localStorage.activity_id_generator=id
}

Activity.mark_status=function(){
    localStorage.setItem("activity_status_temp","before_running")
}

Activity.find_all_activities=function(){
    return _.filter(JSON.parse(localStorage.activities),function(activity){
        return activity.user == localStorage.current_user
    })
}

Activity.find_activities_running_on_sign_up=function(){
    var activities = Activity.find_all_activities()
    var activity_running =_.find(activities,function(activity){
        return activity.status =='running'
    })
    return activity_running!=undefined ||localStorage.activity_status_temp=="running"
}

Activity.find_bid_running_on_sign_up=function(){
    var bid_running = _.find(JSON.parse(localStorage.getItem('bids')),function(bid){
        return bid.activity_id==localStorage.current_activity_id&&
            bid.name==localStorage.current_bid

    })
    if(bid_running){
        return localStorage.bid_status_temp=="running" ||bid_running.status=='running'
    }
    return false
}
Activity.activity_is_process=function(){
    return Activity.find_activities_running_on_sign_up()||
        Activity.find_bid_running_on_sign_up()
}

Activity.scan_sign_up_information_marks=function(activity_name){
    localStorage.current_activity = activity_name
    localStorage.current_activity_id = Activity.find_activity_id_(activity_name)
}
Activity.find_activity_id_=function(activity_name){
    return _.find(JSON.parse(localStorage.activities),function(activity){
        return activity.name == activity_name
    }).id
}
Activity.check_input_name_repeat=function(new_name){
    var activities = Activity.find_all_activities
    return _.find(activities,function(activity){
        return activity.name==new_name
    })
}
Activity.save_current_user=function(user){
    localStorage.current_user=user
}
Activity.find_current_activities=function(){
    var activity_={} ,_activity=[]
    var activities= _.filter(JSON.parse(localStorage.activities.replace(/id/g,'activity_id')),function(activity){
        return activity.user==localStorage.current_user
    })
    _.map(activities,function(activity){
       activity_['activity_id']=activity.activity_id
       activity_['name']=activity.name
       activity_['user']=activity.user
       _activity.push(activity_)
       activity_={}
    })
    return _activity
}
Activity.find_sign_ups=function(){
    var sign_up_={},_sign_ups=[]
    var sign_ups= _.filter(JSON.parse(localStorage.sign_ups),function(sign_up){
        return sign_up.user==localStorage.current_user
    })
    _.map(sign_ups,function(sign_up){
        sign_up_['name']=sign_up.name
        sign_up_['phone']=sign_up.phone
        sign_up_['activity_id']=sign_up.activity_id
        sign_up_['user']=sign_up.user
        _sign_ups.push(sign_up_)
        sign_up_={}
    })
    return _sign_ups
}
Activity.find_bids=function(){
    var bids_array=[]
    var current_bids=_.filter(JSON.parse(localStorage.bids),function(bid){
        return bid.user==localStorage.current_user
    })
    var new_bids=_.each(current_bids,function(bid){
        if(bid.biddings){
            var activity_id=bid.activity_id
            _.map(bid.biddings,function(bidding){
                bidding['bid_name']=bid.name
                bidding['activity_id']=bid.activity_id
                bidding['user']= bid.user
                bidding['status']= 'running'
                bidding['name']= Activity.find_name(bidding.phone,activity_id).name
                bids_array.push(bidding)
            })
        }
    })
    return bids_array
}
Activity.find_bid_list=function(){
    var bid_list=[],bids_array_=[],bids={}
    var bid_of_current_user = _.filter(JSON.parse(localStorage.bids),function(bid){
        return bid.user==localStorage.current_user
    })
    var bid_group=_.groupBy(bid_of_current_user, function (bid) {
        return bid.activity_id;
    });
    _.map(bid_group, function (value, key) {
        bid_list.push({'activity_id':key,'bid_name':value,'user':value[0].user})
    })
    var new_bids=_.each(bid_list,function(bid){
        if(bid.bid_name){
            _.map(bid.bid_name,function(bidding){
                bids['activity_id']=bidding.activity_id
                bids['user']= bidding.user
                bids['name']= bidding.name
                bids_array_.unshift(bids)
                bids={}
            })
        }
    })
    return bids_array_.reverse()
}
Activity.find_win=function(){
    return _.filter(JSON.parse(localStorage.winners),function(win){
        return win.user==localStorage.current_user
    })
}
Activity.find_name=function(phone,current_activity_id){
    return _.find(JSON.parse(localStorage.sign_ups),function(sign_up){
        return sign_up.activity_id==current_activity_id&&
            sign_up.phone==phone
    })
}