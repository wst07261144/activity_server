
var native_accessor = {

    send_sms: function (phone, message) {
        native_access.send_sms({"receivers":[{"name":'name', "phone":phone}]}, {"message_content":message});
    },

    receive_message: function (json_message) {
        if (typeof this.process_received_message === 'function') {
            this.process_received_message(json_message);
        }
    },

    process_received_message: function (json_message) {

        check_activity_or_bid_sign_up(json_message)
    }
};

function notify_message_received(message_json) {
    _.each(message_json.messages, function (message) {
        var SMSObj = {
            "text": message.message.replace(/^\s+|\s+$/g, ''),
            "phone": message.phone
        }
        native_accessor.receive_message(SMSObj);
    })
}

function check_activity_or_bid_sign_up(SMSObj) {
    var mark = SMSObj.text.substring(0, 2).toUpperCase()
    var phone = SMSObj.phone
    if (mark == "BM") {
        var name = SMSObj.text.substring(2).replace(/^\s+|\s+$/g, '')
        return process_activity_sign_up(name, phone)
    }
    if (mark == 'JJ') {
        var bid = SMSObj.text.substring(2).replace(/^\s+|\s+$/g, '')
        return process_bidding(bid, phone)
    }

}
function process_activity_sign_up(name, phone) {
    if (localStorage.activity_status_temp == 'running') {
        return SignUp.judge_repeat_name(name, phone)
    }
    SignUp.reply_message(phone,localStorage.activity_status_temp,'activity')
}
function process_bidding(bid, phone) {
    if (localStorage.bid_status_temp == "running") {
        return Bidding.judge_has_signed(bid, phone)
    }
    SignUp.reply_message(phone,localStorage.bid_status_temp,'bid')
}
