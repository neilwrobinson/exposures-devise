# Rails 7 Example App with Devise and Tachyons CSS
Rails 7 with Devise 4.8.1 and Tachyons CSS

This project is meant to serve as an example implementation of the Devise gem in a Rails 7 application. 

For learning purposes, I wanted to use both Active Storage and Carrierwave. 

Feel free to use this as a skeleton for your project, fork it for your own purposes, or contribute to this repo.

This project is a work in progress; I plan to add more authentication features and better styling.

## Getting Started

### Requirements
- Ruby 3.2.1
- Rails 7.0.5

### Install

```
git clone https://github.com/neilwrobinson/exposures-devise.git
cd exposures-devise

bundle install
rails db:create
rails db:migrate

rails s
```

## App Screenshots

### Home Index Page
![home-page](/media/2022-06-08-150451_1600x900_scrot.png)

### New Registrations

![sign-up](/media/2022-06-08-150511_1600x900_scrot.png)

### New Session

![sign-in](/media/2022-06-08-150325_1600x900_scrot.png)

### Active Storage

The model photo and photos controller are using Active Storage. The photo model has tagging capabilities.

### CarrierWave



## References

I took inspiration from [this project](https://github.com/imhta/rails_6_devise_example). If you are using Rails 6, be sure to check it out!