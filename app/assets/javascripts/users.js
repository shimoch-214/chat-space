$(document).on('turbolinks:load', function(){
  $('#user-search-field').on('keyup', function() {
    function userList(user) {
      html = 
      `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user.name}</p>
        <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="ユーザーのid" data-user-name="ユーザー名">追加</div>
      </div>
      `
      return html;
    }

    var keyword = $(this).val();
    if (keyword == "") {
      $('#user-search-result').empty();
      return
    }
    $.ajax({
      url: '/users',
      type: 'GET',
      dataType: 'json',
      data: { keyword: keyword }
    })
    .done(function(users) {
      $('#user-search-result').empty();
      users.forEach(function(user) {
        var html = userList(user);
        $('#user-search-result').append(html);
      })
      
    })
    .fail(function() {
      alert("エラーが発生しました。");
    })
  })
})