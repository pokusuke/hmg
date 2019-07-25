App.msg = App.cable.subscriptions.create("MsgChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    return $('#chat-index').append('<li>'+data.msg+'</li>');
  },

  post: function(msg) {
    return this.perform('post',{msg: msg});
  }
});
