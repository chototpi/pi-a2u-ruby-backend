require "sinatra"
require "pinetwork"
require "json"

set :bind, '0.0.0.0'
set :port, ENV.fetch("PORT", 3000)

get "/ping" do
  "✅ Pi A2U Ruby Backend is running!"
end

post "/api/a2u-test" do
  content_type :json
  begin
    req = JSON.parse(request.body.read)
    uid = req["uid"]
    amount = req["amount"]&.to_s

    if uid.to_s.empty? || amount.to_s.empty?
      halt 400, { success: false, error: "Thiếu uid hoặc amount" }.to_json
    end

    memo = "A2U-Ruby-#{Time.now.to_i}"

    pi = PiNetwork::Client.new(
      api_key: ENV["PI_API_KEY"],
      wallet_private_seed: ENV["APP_PRIVATE_KEY"],
      wallet_public_address: ENV["APP_PUBLIC_KEY"],
      network: (ENV["PI_NETWORK"] || "testnet").to_sym
    )

    payment = pi.create_payment(uid: uid, amount: amount, memo: memo)
    txid = pi.submit_payment(payment)
    pi.complete_payment(identifier: payment[:identifier], txid: txid)

    { success: true, txid: txid }.to_json
  rescue => e
    status 500
    { success: false, error: e.message }.to_json
  end
end
