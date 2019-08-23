$(function() {
  function buildHTML(message, imageTag) {
    var html =
    `
    <div class="chat-messages__info" data-id="${message.id}">
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

  var reloadMessages = function() {
    var last_message_id = $('.chat-messages__info').last().attr('data-id');
  
    $.ajax({
      url: "api/messages",
      type: 'GET',
      data: { id: last_message_id},
      dataType: 'json'
    })
    .done(function(messages) {
      if (messages.length > 0) {
        messages.forEach(function(message) {
          var imageTag = (message.image == null) ? "" : `<img src=${message.image} class='chat-messages__message--image'>`;
          var html = buildHTML(message, imageTag);
          $('.chat-messages').append(html);
        })
        $('.chat-messages').animate({scrollTop: $('.chat-messages')[0].scrollHeight}, 'slow');
      }
    })
    .fail(function(){
      alert('メッセージの取得に失敗しました。');
    })
  }

  setInterval(reloadMessages, 5000);

  $('#new_message').on('submit', function(e) {
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
      $('#new_message')[0].reset();
      $('.chat-messages').animate({scrollTop: $('.chat-messages')[0].scrollHeight}, 'slow');
      $('#message-btn').attr('disabled', false);
    })
    .fail(function() {
      alert('メッセージの送信に失敗しました。')
      $('#message-btn').attr('disabled', false);
    })
  })
})


