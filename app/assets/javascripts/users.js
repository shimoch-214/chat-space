// $(document).on('turbolinks:load', function(){
// $(function(){
$(window).on('load', function() {
  function userList(user) {
    html = 
    `
    <div class="chat-group-user clearfix">
      <p class="chat-group-user__name">${user.name}</p>
      <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id=${user.user_id} data-user-name="${user.name}">追加</div>
    </div>
    `
    return html;
  }

  function noUsers(msg) {
    html =
    `
    <div class="chat-group-user clearfix">
      <p class="chat-group-user__name">${msg}</p>
    </div>
    `
    return html;
  }

  function buildChatMember(user_id, user_name) {
    var html = 
    `
    <div class="chat-group-user clearfix">
      <input name='group[user_ids][]' type='hidden' value=${user_id}>
      <p class='chat-group-user__name'>${user_name}</p>
      <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
    </div>
    `
    return html;
  }

  function getAddedUsers() {
    var added_users = new Array;
    $('[name="group[user_ids][]"]').each(function(i, ele) {
      added_users.push(Number($(ele).val()));
    })
    return added_users;
  }


  $('#user-search-field').on('keyup', function() {
    console.log("hoge")
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
      console.log("hoge");
      $('#user-search-result').empty();
      var added_users = getAddedUsers();
      if (users.length != 0) {
        users.forEach(function(user) {
          if (!added_users.includes(user.user_id)) {
            var html = userList(user);
            $('#user-search-result').append(html);
          }
        })
      }
      else {
        var html = noUsers("一致するユーザーが見つかりません。");
        $('#user-search-result').append(html);
      }
    })
    .fail(function() {
      alert("エラーが発生しました。");
    })
  })

  $(document).on('click', '.chat-group-user__btn--add', function() {
      var user_id = $(this).attr('data-user-id');
      var user_name = $(this).attr('data-user-name');
      $(this).parent().remove();
      var html = buildChatMember(user_id, user_name);
      $('#added-users').append(html);
      console.log("hoge")
    })

  $(document).on('click', '.chat-group-user__btn--remove',function(){
    $(this).parent().remove();
  })
})

