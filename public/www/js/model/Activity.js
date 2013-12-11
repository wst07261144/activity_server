function Activity(activity_name, create_time, activity_status) {

    this.activity_name = activity_name;
    this.create_time = create_time || new Date().getTime();
    this.activity_status = activity_status || "before_running"

}
Activity.prototype.save_activity_list_name = function () {
    var activity_list = Activity.find_all_activities();
    activity_list.unshift(this);
    localStorage.setItem("event_name", JSON.stringify(activity_list))
}

Activity.find_all_activities = function () {
    return JSON.parse(localStorage.getItem("event_name"))
}

Activity.find_id_of_running=function(){
    var activities=Activity.find_all_activities()
    for(var i=0;i<activities.length;i++){
        if(activities[i].activity_status=="running"){
            return i
        }
    }
}

Activity.find_activities_running_on_sign_up = function () {

    var activity_running = _.find(Activity.find_all_activities(), function (status) {
        return status == "running"
    })
    return activity_running || localStorage.getItem("activity_status_temp") == "running"
        ||localStorage.getItem("current_activity")!="undefined"
}
Activity.find_activities_running_on_bid=function(){
    return localStorage.getItem("current_activity")
}
Activity.find_process_running=function(){
    return Activity.find_activities_running_on_sign_up()||Activity.find_activities_running_on_bid()
}

Activity.find_all_activity_names = function () {
    var local_activity_name_array;
    var local_activity_list = Activity.find_all_activities();
    return local_activity_name_array = _.map(local_activity_list, function (obj) {
        return  obj.activity_name
    })
}
Activity.check_input_name_repeat = function (activity_input) {

    var activity_name = activity_input.replace(/^\s+|\s+$/g, '');
    var local_activity_list = Activity.find_all_activity_names();
    var activity = _.find(local_activity_list, function (num) {
        return activity_input == num
    })
    return activity;
}
Activity.make_some_create_marks = function () {
    var counter = localStorage.getItem("counter of activity_list");
    counter = parseInt(counter) + 1;
    localStorage.setItem("counter of activity_list", counter);
    localStorage.setItem("activity_status_temp", "before_running");
    localStorage.setItem("mark_of_create_activity", "create activity");
}
Activity.find_counter_of_activity_list=function(){
    return localStorage.getItem("counter of activity_list")
}

Activity.scan_sign_up_information_marks = function (id) {

    localStorage.setItem("sign_up_id", id);
    localStorage.setItem("mark_of_create_activity", "");
}
Activity.save_person_bid_index = function () {
    var local_list = JSON.parse(localStorage.getItem("peron_bid_index"));
    local_list.push("0");
    localStorage.setItem("peron_bid_index", JSON.stringify(local_list));
}












