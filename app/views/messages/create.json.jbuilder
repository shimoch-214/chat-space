json.body            @message.body
json.image           @message.image.url
json.created_at      @message.created_at.strftime('%Y/%m/%d (%a) %X')
json.user_name       @message.user.name
json.id              @message.id