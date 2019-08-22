$(function() {
    $('#new_message').on('submit', function(e) {
    function buildHTML(message, imageTag) {
      var html =
      `
      <div class="chat-messages__info">
      <div class="chat-messages__info--user">
      ${message.user_name}
      </div>
      <div class="chat-messages__info--date">
      ${message.created_at}
      </div>
      </div>
      <div class="chat-messages__message">
      <div class="chat-messages__message--text">
      ${message.body}
      </div>
      ${imageTag}
      </div>
      `
      return html;
    }

    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message) {
      var imageTag = (message.image == null) ? "" : `<img src=${message.image} class='chat-messages__message--image'>`;
      var html = buildHTML(message, imageTag);
      $('.chat-messages').append(html);
      $('#message_body').val('');
      $('#message_image').val('');
      $('.chat-messages').animate({scrollTop: $('.chat-messages')[0].scrollHeight}, 'slow');
      $('#message-btn').attr('disabled', false);
    })
    .fail(function() {
      alert('メッセージの送信に失敗しました。')
      $('#message-btn').attr('disabled', false);
    })
  })
})