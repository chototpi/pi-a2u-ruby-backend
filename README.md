# Pi A2U Ruby Backend

✅ Sinatra + `pi-ruby` SDK example để thực hiện App-to-User (A2U) trên Pi Testnet/Mainnet.

## 📦 Cài đặt

```bash
bundle install
```

## 🌍 Thiết lập môi trường

Trên Render hoặc local, định nghĩa biến:

```
PI_API_KEY=...
APP_PUBLIC_KEY=G_...
APP_PRIVATE_KEY=S_...
PI_NETWORK=testnet
```

## 🚀 Chạy

```bash
ruby app.rb
```

## 🔄 Endpoints

- `GET /ping` → kiểm tra app alive
- `POST /api/a2u-test`
  ```json
  { "uid": "...", "amount": "1.5" }
  ```
  → trả về `{ "success": true, "txid": "..." }`
