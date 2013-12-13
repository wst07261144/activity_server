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
    if(!bid_running){
        return false
    }
}
Activity.activity_is_process=function(){
    return Activity.find_activities_running_on_sign_up()||
        Activity.find_bid_running_on_sign_up()
}

Activity.scan_sign_up_information_marks=function(activity_name){
    localStorage.current_activity = activity_name
}

Activity.check_input_name_repeat=function(new_name){
    var activities = Activity.find_all_activities
    return _.find(activities,function(activity){
        return activity.name==new_name
    })
}

Activity.save_current_user=function(user){
    localStorage.current_user=user
    localStorage.current_activity_id =Activity.find_activity_id()
}
Activity.find_activity_id=function(){
    var activities = JSON.parse(localStorage.activities)
    var current_activity= _.find(activities,function(activity){
        return activity.user==localStorage.current_user
    })
    if(!current_activity){
        current_activity=''
    }
    return current_activity.id
}