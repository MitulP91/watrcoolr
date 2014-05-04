var room_id;

$(document).ready(function() {
  prepareBroadcast();
  var value = $('input[name=msg_content]').val();

  $('#input-box form input[type=submit]').on('click', function() {
    sendMessage($('#msg_content').val(), parseInt($('#new_message').attr('class')));
    // $('#msg_content').val('');
  });

  // Submit on Enter-Key
  $('#input-box').keypress(function(ev){
    if (ev.keyCode == 13 && $('#msg_content').val().length > 0) {
      sendMessage($('#msg_content').val(), parseInt($('#new_message').attr('class')));
      console.log('test');
    }
  })

  //Hide Self-Destruct Functions
  $('#self_destruct_false').on('click',function() {
    $('#self_destruct_time').hide();
  })

  $('#self_destruct_true').on('click',function() {
    $('#self_destruct_time').show();
  })

  // Declare functions
  function sendMessage(string, room_id) {
    $.ajax({
      type: 'POST',
      url: '/rooms/clear_msg_content',
      dataType: 'text',
      data: {msg_content: string, room: room_id},
      success: function(){
        $('#msg_content').val('');
      }
    });
  }

  function getRoomId() {
    var room_id_unparsed = $('.room').attr('id');
    room_id = parseInt(room_id_unparsed.replace('room-',""));
  }

  // Prepares all redis events when threads are open
  function prepareBroadcast() {
    if((document.URL).match(/\/rooms\/.+/)) {
      getRoomId(); // changes global variable to user's room id
      var source = new EventSource('/rooms/events?room_id=' + room_id);
      var room;

      // Publishes to add message to chatroom ----------------------------------------------
      source.addEventListener("add_message_"+room_id, function (e) {
        data = JSON.parse(e.data);
        // $('#room-' + room_id + " #messages").append('<div><span class="content">'+data.message+'</span><br/><span class="author"> - '+data.author+'</span></div><hr/></div>');
        var html = '';
        if(data.author_id == data.message_author_id) {
          html += '<div class="current-user-msg chat-msg" id="message-' + data.message_id + '">';
        } else {
          html += '<div class="user-msg chat-msg" id="message-' + data.message_id + '">';
        }
        html += '<h4>' + data.author + '</h4>';
        html += '<p class="msg-body">' + data.message + '</p>';
        html += '</div><div style="clear:both"></div><br>';

        $('#room-' + room_id + " #messages").append(html);
        // $('#room-' + room_id + " #messages").append('<p class="chat-msg" id="message-' + data.message_id + '"><span class="user-msg">' + data.author + ':</span> ' + data.message + '</p>');
        $('#messages').scrollTop(999999);
      });

      source.addEventListener("remove_message_"+room_id, function(e) {
        data = JSON.parse(e.data);
        $('#message-' + data.message_id).fadeOut(200);
      });
    }
  }

  // Scroll to bottom
  $('#messages').scrollTop($('#messages')[0].scrollHeight);


});