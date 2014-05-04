var room_id;

$(document).ready(function() {
  prepareBroadcast();
  var value = $('input[name=msg_content]').val();

  $('#input-box form input[type=submit]').on('click', function() {
    sendMessage($('#msg_content').val(), parseInt($('#new_message').attr('class')));
    // $('#msg_content').val('');
  });

  // Declare functions
  function sendMessage(string, room_id) {
    
    console.log('message sent');
    $.ajax({
      type: 'POST',
      url: '/rooms/add_message',
      dataType: 'text',
      data: {msg_content: string, room: room_id},
      success: function(){
        console.log('blarg');
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
  // Checks to see that the user is in a room
  // TODO: Find a better way to match URL
    if((document.URL).match(/\/rooms\/.+/)) {
      getRoomId(); // changes global variable to user's room id
      var source = new EventSource('/rooms/events?room_id=' + room_id);
      var room;

      // Publishes to add message to chatroom ----------------------------------------------
      source.addEventListener("add_message_"+room_id, function (e) {
        data = JSON.parse(e.data);
        console.log(data);
        // $('#room-' + room_id + " #messages").append('<div><span class="content">'+data.message+'</span><br/><span class="author"> - '+data.author+'</span></div><hr/></div>');
        $('#room-' + room_id + " #messages").append('<p class="chat-msg"><span class="user-msg">' + data.author + ':</span> ' + data.message + '</p>');
        $('#messages').scrollTop(999999);
      });
    }
  }

  // Scroll to bottom
  $('#messages').scrollTop($('#messages')[0].scrollHeight);


});