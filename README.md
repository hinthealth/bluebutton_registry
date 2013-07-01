[![Build
Status](https://travis-ci.org/hlth-labs/blue_register.png?branch=master)](https://travis-ci.org/hlth-labs/blue_register)


# Blue Register

Description: A basic implementation of a Blue Button+ Register service
in Ruby on Rails.

## Project Setup

Create your very own Blue Button+ Registry service!

0. Requirements: 
    * mongodb - [OS X Install guide](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)
1. Run ```bundle install```
2. Run ```rake spec``` to ensure everything is setup
3. (optional) Run ```rake db:seed``` to load your local environment with sample data 
4. Run ```rails server``` and visit your new registry service at
   [localhost:3000](localhost:3000)

## Testing

_How do I run the project's automated tests?_

All testing is handled in [rspec 2](https://www.relishapp.com/rspec). To run the suite, simply run `rake`

When a new pull request is created, the tests will be automatically run on travis-ci

## Deploying

### How to deploy to [blue-button.org](blue-button.org) via Heroku

1.  Getting setup (first time only)

	```heroku git:remote -a blue-register-production```

2.  Deploying to heroku

	```git push heroku master```


## Contributing changes

  * fork this project
  * write a test for your feature/bug
  * make it pass
  * create a pull request!
  
## Credits
Created by [Graham Melcher](https://github.com/melcher), contact me at <graham@hlth.io>

## License
This software made available under the [MIT License](http://opensource.org/licenses/MIT)
