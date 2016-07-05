# Marchex

Ruby gem for working with the Marchex JSON api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marchex'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marchex

## Usage
Create a connection using your Marchex account email address and password:

@testcon = Marchex::Marchexapi.new("user@marchex.com", "password")

# @testcon.account_list
    Retrieves all accounts       

# @testcon.client_ad_list(client_id, status)
    Retrieves all ad campaigns for a client account. If disabled or active is passed for the status, only those ads will be returned. 
      
# @testcon.ad_forward_list(campaign_id)
    Retrieves all forwarding numbers for a single ad campaign

# @testcon.ad_record_status(campaign_id)
    Checks if an ad campaign is set to record
       
# @testcon.user_list(account_id)
    List all users in a client account
      
# @testcon.user_permissions(user_id)
    Grab permissions to see if a user is an admin
      
# @testcon.ad_custom_define(acc_id,field_number, field_name, field_type, field_values)
    Define a custom field for an ad    

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/marchex.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

