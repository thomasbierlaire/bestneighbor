module SmsManagement extend ActiveSupport::Concern

  def format_tel(phonenumber)
    return phonenb = "+33" + phonenumber[1..9]
  end

  def send_sms(phonenumber, message)
    uri = URI.parse("https://api.smspartner.fr/v1/send")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({
      "apiKey" => "7059942ad5244ef71e98d0107f21d1153f9946bf",
      "phoneNumbers" => "#{phonenumber}",
      "message" => "#{message}",
      "sender" => "BNeighbor",
      "gamme" => "2"
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts "RESPONSE CODE" + response.code
    puts "RESPONSE BODY" + response.body
    puts "#{message}" + "#{phonenumber}"
  end

end
