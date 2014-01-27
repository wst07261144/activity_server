module ShowsHelper
  def show_bid_situation
    if @win.nil?||!(@win[:activity_id] == @bidlist[:activity_id]&&@win[:bid_name]== @bidlist[:name])
      msg1 = '参与人数(' + @bidding_detail.length.to_s
      msg2 = '/'
      msg3 =  @num.length.to_s+')'
      return msg1+msg2+msg3
    end
    return '本次竞价无效' if @win1=='true'&&@win[:name]=='竞价无效'
    if  @win1=='true'&&@win[:name]!='竞价无效'
      msg4="获胜者:"+@win[:name]
      msg5='出价:'+@win[:price]+'元'
      msg6='手机号:'+@win[:phone]
      return msg4+msg5+msg6
    end

  end
  def show_activity_situation
    return '活动正在进行中' if @win.nil?
    return '本次竞价无效' if !@win.nil?&&@win[:name]=='竞价无效'
    msg1='获胜者:'+@win.name
    msg2='出价:'+@win.price+'元'
    msg3='手机号:'+@win.phone
    return  msg1+msg2+msg3 if !@win.nil?&&@win[:name]!='竞价无效'
    end

end
