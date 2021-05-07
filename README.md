# CSSA Hub!: A web application provides carpool services for students at Texas A&M University
* Incorporated Agile practices and conduct weekly meetings with our client (TAMU CSSA Director).
* Designed a web service that allows the user to provide/request rides. Rides that match passenger’s requirements will be automatically suggested to them.
* Users can view all posted rides or filter rides depending on their choice. Users can also update their profiles or modify their posted rides. Admin can achieve or restore users and manage posts to maintain a healthy user environment.

## Watch our project demo: https://youtu.be/HuHHqQZgk4A
Heroku Link: https://cssahub.herokuapp.com/

## Installation
* Install Ruby
  * Install rbenv following [this guide](https://github.com/rbenv/rbenv#installing-ruby-versions). Make sure `export PATH="$HOME/.rbenv/bin:$PATH"` and `eval "$(rbenv init - zsh)"` is added to your shell profile. Source your shell profile and restart terminal.
  * Install ruby-build following [this guide](https://github.com/rbenv/ruby-build)
  * Install Ruby 2.5.3 `rbenv install 2.5.3`
  * Set local Ruby environment `rbenv local 2.5.3`
* Install Ruby gems
  * `gem install bundler`
  * `bundle update`
* Setup `./bin/setup`
* Running on local `./bin/rails server`

### We are the Super Scrum Bros!
  - Yumei Li (Product Owner)
  - Alyssa Schaeffer (Scrum Master)
  - Megan Grahmann (Developer)
  - David Ratliff (Developer)
  - Suqian Wang (Developer)

### API Used
Google Authentication for Login/Signup: [OmniAuth Google OAuth 2.0](https://github.com/zquestz/omniauth-google-oauth2)
Google Maps APIs: [Geocoding API, Places API, Maps JavaScript API](https://console.cloud.google.com/apis/library?filter=category:maps&project=silent-space-313003&authuser=2&folder&organizationId&supportedpurview=project)

### Environment
Ruby Version: 2.5.3  
Rails Version: 5.2.2  
Automated Testing:
* Cucumber    
* RSpec  
* Capybara  
