getParam = (name, url) ->
  if !url
    url = window.location.href
  name = name.replace(/[\[\]]/g, "\\$&")
  regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)")
  results = regex.exec(url);
  if !results 
    return null
  if !results[2]
    return ''
  return decodeURIComponent(results[2].replace(/\+/g, " "))

getLastDic = (url) ->
  if !url
    url = window.location.href
  result = url.split("/")
  return result[result.length - 1].split("&")[0]

App.msg = App.cable.subscriptions.create { channel: "MsgChannel",room:getParam('room'), rec:getLastDic() },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data);
    appendStr = ""
    if(data['message']['pic'])
      appendStr = """
        <li class='msg-item'>
          <div class='table-row'>
            <div class="msg-sender-img">
              <img src="/assets/no-image-human.png">
            </div>
            <div class="msg-container">
              #{data['message']['sender_name']}
              <br>
              <span class="msg-content">
                #{data['message']['msg']}
                <br>
                <span class="msg-img"><img src="#{data['message']['pic']}"></span>
              </span>
            </div>
          </div>
        </li>
      """
    else
      appendStr = """
        <li class='msg-item'>
          <div class='table-row'>
            <div class="msg-sender-img">
              <img src="/assets/no-image-human.png">
            </div>
            <div class="msg-container">
              <span>#{data['message']['sender_name']}</span>
              <br>
              <span class="msg-content">#{data['message']['msg']}
            </div>
          </div>
        </li>
      """ 
    $('.msg-list').append appendStr
  speak:(message) ->
    @perform 'speak', message: message

$(document).on 'click','#msg-submit',(event) ->
    text = $.trim($(".msg").val())
    has_text = if text.length > 0 then true else false
    picture = $("#file_input")
    console.log("きてる？")
    console.log(picture)
    has_picture = if picture.get(0).files.length > 0 then true else false
    console.log(has_picture)
    if has_text or has_picture
      if has_picture
        console.log("mkoko")
        file_name = picture.get(0).files[0].name
        reader = new FileReader()
        reader.readAsDataURL picture.get(0).files[0]
        reader.addEventListener "loadend", ->
          message = {
            msg: text,
            pic: reader.result
          }
          console.log(message)
          console.log(App.msg)
          App.msg.speak message 
      else
        message = {
          msg: text
          pic: ""
        }
        console.log(message)
        console.log(App.msg)
        App.msg.speak message
    $(".msg").val('')
    $("#file_input").val('')
    event.preventDefault()

