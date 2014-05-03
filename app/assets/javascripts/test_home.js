var room_id;

$(document).ready(function() {
  prepareBroadcast();
  $('#input-submit').on('click', function(e) {
    e.preventDefault();

    // Pull input box content
    var content = $('#input-content').val();
    $('#input-content').val('');
    var html = '<p>'+content+'</p>';

    // Append it to message box
    sendMessage(content);
    $('#message-box').append(html);
  });

  // Declare functions
  function sendMessage(string) {
    $.ajax({
      type: 'POST',
      url: '/rooms/add_message',
      dataType: 'json',
      data: {message: string}
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
        console.log('chat redis triggered');
        data = JSON.parse(e.data);
        console.log(data);
        num_messages++;
        checkMessages();
        $('#room-' + room_id + " #messages").append('<div><span class="content">'+data.message+'</span><br/><span class="author"> - '+data.author+'</span></div><hr/></div>');
        $('#messages').scrollTop(999999);
      });
    }
  }
});