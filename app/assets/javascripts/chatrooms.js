$(document).ready(function() {
  var $messageSendButton = $('#message-send-btn');
  var $contentField = $('#content');
  var $token = $('meta[name="csrf-token"]').prop("content");

  // Select the Chatroom div and store its ID in a variable so that we can send it inside the AJAX request down below:
  var chatroom_id = $('.chatroom').data('chatroom-id');

  $messageSendButton.on("click", function() {
    event.preventDefault();
    event.stopPropagation();

    $.ajax({
      // Modify the URL so that it goes to the correct chatroom:
      url: `/chatrooms/${chatroom_id}/messages`,
      type: "post",
      dataType: "json",
      data: {content: $contentField.val()},
      headers: {"X-CSRF-TOKEN": $token},
      success: function(response) {
        $contentField.val("");
      },
      error: function(response) {
        console.log(response);
      }
    })
  });
});
