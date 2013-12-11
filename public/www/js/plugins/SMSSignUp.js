
function SMSSignUp() {
}
SMSSignUp.judge_activity_status_running=function(name,phone_number){

    localStorage.getItem("activity_status_temp")=="running"? SMSSignUp.is_repeat_information(name,phone_number):
    SignUp.reply_message(phone_number,SignUp.get_activity_status(),"activity")
}

SMSSignUp.is_repeat_information=function(name,phone_number) {
    var phone_is_repeat = false;
    var id=SignUp.get_activity_id();
    var already_save_activity_information = JSON.parse(localStorage.getItem("person_information"+id));
    var already_save_activity_name = []; console.log("6")
    _.map(already_save_activity_information, function (i_activity) {
        already_save_activity_name.push(i_activity.phone)
    });
    _.map(already_save_activity_name, function (i_phone) {
        if(Number(i_phone)==Number(phone_number)){
            phone_is_repeat = true;
        }
    })
    phone_is_repeat==false?SMSSignUp.save_and_process(name,phone_number):
        SignUp.reply_message(phone_number,"running2","activity")
}

SMSSignUp.save_and_process=function(name,phone){
    new SignUp(name,phone).save_sign_up_information();
    SignUp.refresh_and_reply_message(phone)
}