require 'telegram/bot'
require 'httparty'


token = '418062343:AAH69ab4l20aLzJcpkg06HCgqxYFUxSUcKs'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Bot para saber el precio del dolar, la tasa de cambios y generales que quiera hacer")
    
    when '/moneycl'
      #response = HTTParty.get('http://mindicador.cl/api')
      #bot.api.send_message(chat_id: message.chat.id, text: "#{response.to_s}")
    when '/moneyvzla'
      #response = HTTParty.get('https://s3.amazonaws.com/dolartoday/data.json')
      #bot.api.send_message(chat_id: message.chat.id, text: "#{response.to_s}")
    end
  end
end