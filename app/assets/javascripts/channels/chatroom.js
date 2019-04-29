$(document).ready(function() {
  $('[data-channel-subscribe="chatroom"]').each(function(index, element) {
    // Let's select the message-div so that we can append the new message to it.
    var $messageDiv = $('#message-div');

    App.cable.subscriptions.create(
      {
        channel: "ChatroomChannel",
      },

      // Now let's make the recieved function append to the page and then scroll down.
      {
        received: function(data) {
          $.ajax({
            url: "/get_current_user",
            type: "get",
            dataType: "json",
            success: function(response) {
              if (response.current_user_id === data.user.id) {
                var $newMessage = $(`
                  <div class="message my-message ml-auto">
                    <big>${data.user.email}</big>
                    <br>
                    <small>${data.message.content}</small>
                  </div>
                `).hide();
              } else {
                var $newMessage = $(`
                  <div class="message other-user-message mr-auto">
                    <big>${data.user.email}</big>
                    <br>
                    <small>${data.message.content}</small>
                  </div>
                `).hide();              
              }

              $messageDiv.append($newMessage.fadeIn());
              $messageDiv.animate({ scrollTop: $messageDiv.prop("scrollHeight")}, 1000);
            },
            error: function(response) {
              console.log(response);
            }
          });
        }
      }
    );
  });
});
