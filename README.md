# country_info_app

A Flutter app which allows users to view a list of countries and their information(such as time zone, flag, country code and currency).

## ✨ Features
- List of countries from API
- Country search
- Details about the selected country
- Dark theme


## ⚙️ Dependencies & Packages
- provider for state management
- flutter_screenutil for responsiveness
- http for API calls
- [Country API](https://restcountries.com/docs/countries) (v5)
- intl for number formatting
- grouped_list to group countries alphabetically
- The font used in this project is Axiforma
- Flag images from the v5 Countries API

## 🚀 Setup Instructions
1. Clone the Repository
 ```
   git clone https://github.com/bema-fabiyi/country_info_app.git
```
2. Navigate to the folder
 ```
  cd [project folder]
 ```
 3. Copy `.env.example` to `.env` and add your REST Countries API key:
```
 REST_COUNTRIES_API_KEY=your_api_key
 ```

 Get an API key from [REST Countries](https://restcountries.com/sign-up), then
 run:
 ```
 flutter pub get
 flutter run
 ```

 The `.env` file is ignored by Git. Flutter bundles assets into the app, so a key
 used this way can still be extracted from a built app; use a backend proxy to
 protect credentials in production.
## 📱 Try app on browser
use [this link](https://appetize.io/embed/b_5olrusj5mfc25u7ceaepubpjsi)
