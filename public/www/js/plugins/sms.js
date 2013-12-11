var native_accessor = {

    process_received_message: function (json_message) {
        var phone_number = json_message.phone
        check_activity_or_bid_sign_up(json_message)
    },

    send_sms: function (phone, message, success_callback, failed_callback) {

        native_access.send_sms({"receivers": [
                {"name": 'name', "phone": phone}
            ]}, {"message_content": message}, success_callback,
            failed_callback, this);
    },

    receive_message: function (json_message) {

        if (typeof this.process_received_message === 'function') {
            this.process_received_message(json_message);
        }
    }
};

function notify_message_received(message_json){

    _.each(message_json.messages, function (message) {
        var SMSObj = {
            "text": message.message.replace(/^\s+|\s+$/g, ''),
            "phone": message.phone
        }
        native_accessor.receive_message(SMSObj);
    })
}

function check_activity_or_bid_sign_up(SMSObj){
    var msg_start = SMSObj.text.substring(0, 2).toUpperCase();
    var msg_end = SMSObj.text.substring(2).replace(/^\s+|\s+$/g, '');
    if (msg_start == "BM"&&msg_end) {
        var name= SMSObj.text.substring(2);
        return SMSSignUp.judge_activity_status_running(name,SMSObj.phone);
    }
    if (msg_start == "JJ"&&msg_end) {
        var bid= SMSObj.text.substring(2);
        localStorage.setItem("current_bid",bid)
        return SMSBid.judge_bid_running(SMSObj.phone);
    }
}

var success_callback = function (result, context) {
    console.log(result);
};
var failed_callback = function (result) {
    console.log(result);
}

