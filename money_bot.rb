require 'telegram/bot'
require 'httparty'
#require 'pry'


token = '418062343:AAH69ab4l20aLzJcpkg06HCgqxYFUxSUcKs'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Bot para saber el precio del dolar, la tasa de cambios y generales que quiera hacer")
    when '/moneycl'
      response = HTTParty.get('http://mindicador.cl/api')
      uf_value = esponse["uf"]["valor"]
      dolar_value = esponse["dolar"]["valor"]
      utm_value = esponse["utm"]["valor"]
      bot.api.send_message(chat_id: message.chat.id, text: "**UFT:** #{uf_value} \n  **Dolar:** #{dolar_value} \n **Utm:** #{utm_value}")
    when '/moneyvzla'
      response = HTTParty.get('https://s3.amazonaws.com/dolartoday/data.json')
      dolartoday = response["USD"]["dolartoday"]
      dolar_cucuta = response["USD"]["efectivo_cucuta"]
      bitcoin_ref = response["USD"]["bitcoin_ref"]
      bot.api.send_message(chat_id: message.chat.id, text: "**DolarToday:** #{dolartoday} \n **DolarCucuta:** #{dolar_cucuta} \n **bitcoin_vzla:** #{bitcoin_ref}")

    when '/clave'
      vzla = HTTParty.get('https://s3.amazonaws.com/dolartoday/data.json')
      cl = HTTParty.get('http://mindicador.cl/api')
      dolartoday = vzla["USD"]["dolartoday"]
      dolar_cl= cl["dolar"]["valor"]
      real = dolartoday / dolar_cl
      bot.api.send_message(chat_id: message.chat.id, text: "**DolarToday:** #{dolartoday} \n **DolarCl:** #{dolar_cl} \n **Real:** #{real}")
    
    when '/veacl'
      vzla = HTTParty.get('https://s3.amazonaws.com/dolartoday/data.json')
      cl = HTTParty.get('http://mindicador.cl/api')
      dolartoday = vzla["USD"]["dolartoday"]
      dolar_cl= cl["dolar"]["valor"]
      real = dolar_cl / dolartoday 
      bot.api.send_message(chat_id: message.chat.id, text: "**DolarToday:** #{dolartoday} \n **DolarCl:** #{dolar_cl} \n **Real:** #{real}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Bot para saber el precio del dolar, la tasa de cambios y generales que quiera hacer")
    end
  end
end