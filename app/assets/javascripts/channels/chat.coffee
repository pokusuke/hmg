App.chat = App.cable.subscriptions.create { channel: "ChatChannel",room:"Test Room"},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if(data['message']['pic'])
      $('#messages').append '<li>'+ data['message']['msg'] + '<br><img src="'+data['message']['pic']+'"></li>'
    else
      $('#messages').append '<li>'+ data['message']['msg'] + '</li>'


  speak: (message) ->
    @perform 'speak',message: message

$(document).on 'click','#submit',(event) ->
    text = $.trim($("#chat_input").val())
    has_text = if text.length > 0 then true else false

    picture = $("#file_input")
    has_picture = if picture.get(0).files.length > 0 then true else false
    
    if has_text or has_picture
      if has_picture
        file_name = picture.get(0).files[0].name
        reader = new FileReader()
        reader.readAsDataURL picture.get(0).files[0]
        reader.addEventListener "loadend", ->
          message = {
            msg: text,
            pic: reader.result
          }
          App.chat.speak message 
      else

        message = {
          msg: text
          pic: ""
        }
        App.chat.speak message
    $("#chat_input").val('')
    $("#file_input").val('')
    event.preventDefault()