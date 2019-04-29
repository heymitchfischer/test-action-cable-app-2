$(document).ready(function() {
  // Subscribe to the notifications channel for each channel you've joined up in the navigation bar:
  $('[data-channel-subscribe="notification"]').each(function(index, element) {
    // Select the navigation badge (this is where we'll put a little "new" update each time you have an unread message):
    var $notificationBadge = $(element);

    // Then select the chatroom that you're listening to notifications from:
    var chatroom_id = $notificationBadge.data('chatroom-id');

    // Now we create a subscription to the notification channel and pass along the chatroom_id that we want to be notified about:
    App.cable.subscriptions.create(
      {
        channel: "NotificationChannel",
        chatroom_id: chatroom_id
      },
      {
        // If we get a broadcast from the notification channel, that means we've recieved a new message. Therefore, let's add a little "new" update in the navigation bar:
        received: function(data) {
          $notificationBadge.html("new");
        }
      }
    );
  });
});