require 'telegram/bot'
require 'httparty'
require 'pry'


token = ENV["TOKEN"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Bot para saber el precio del dolar, Chile: /moneycl Vzla: /moneyvzla, la tasa de cambios Cl a Ve: /clave y Ve a Cl: /veacl")
    when '/moneycl'
      response = HTTParty.get('http://mindicador.cl/api')
      uf_value = response["uf"]["valor"]
      dolar_value = response["dolar"]["valor"]
      utm_value = response["utm"]["valor"]
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
    
    when '/clima'
      condes = HTTParty.get('http://samples.openweathermap.org/data/2.5/weather?id=3884448&appid=b1b15e88fa797225412429c1c50c122a1')
      providencia = HTTParty.get('http://samples.openweathermap.org/data/2.5/weather?id=3875139&appid=b1b15e88fa797225412429c1c50c122a1')
      metropolitana = HTTParty.get('http://samples.openweathermap.org/data/2.5/weather?id=3873544&appid=b1b15e88fa797225412429c1c50c122a1')
      bot.api.send_message(chat_id: message.chat.id, text: "**Condes:** #{condes} \n **Providencia:** #{providencia} \n **Region Metropolitana:** #{metropolitana}")
    else 
      bot.api.send_message(chat_id: message.chat.id, text: "Bot para saber el precio del dolar, Chile: /moneycl Vzla: /moneyvzla, la tasa de cambios Cl a Ve: /clave y Ve a Cl: /veacl")
    end
  end
end