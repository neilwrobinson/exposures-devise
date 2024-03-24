# Rails 7 Example App with Devise and Tachyons CSS
Rails 7 with Devise 4.9.3 and Tachyons CSS

This project is meant to serve as an example implementation of the Devise gem in a Rails 7 application. 

For learning purposes, I wanted to use both Active Storage and Carrierwave. That's why you'll see two models/controllers. 

This project is a work in progress; I plan to add more authentication features, testing, background jobs, and better styling.

## Getting Started

### Requirements
- Ruby 3.2.3
- Rails ~> 7.1.0

### Install

```
git clone https://github.com/neilwrobinson/exposures-devise.git
cd exposures-devise
```

This is meant to be run in docker. See dx folder

Inside the dx/docker-compose.env file please update IMAGE= to reference your docker user name.
```
IMAGE=your_docker_id_here/exposures-devise
PROJECT_NAME=exposures-devise
DEFAULT_SERVICE=exposures-devise
```
Then Run
```
dx/build
dx/start
dx/exec bash 
```
dx/exec bash command will run a bash shell for you to run rails


```
bundle install
bin/setup
bin/run
```
This should get your started.

You can also run:
```
bin/psql (for psql prompt)
bin/ci   (for running tests)

```

### 
Sidekiq
If you are missing bin/sidekiq files (binstub), run:
```
bundle binstub sidekiq
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

I also use https://github.com/sustainable-rails/sustainable-rails-dev for the dev environment. This is a big time saver.