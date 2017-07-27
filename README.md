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
```ruby
@testcon = Marchex::Marchexapi.new("user@marchex.com", "password")
```
```@testcon.account_list ```

    Retrieves all accounts       

``` @testcon.client_ad_list(client_id, status) ```

    Retrieves all ad campaigns for a client account. If disabled or active is passed for the status, only those ads will be returned. 
      
``` @testcon.ad_forward_list(campaign_id) ```

    Retrieves all forwarding numbers for a single ad campaign

``` @testcon.ad_record_status(campaign_id) ```

    Checks if an ad campaign is set to record
       
``` @testcon.user_list(account_id)```

    List all users in a client account
      
``` @testcon.user_permissions(user_id) ```

    Grab permissions to see if a user is an admin
      
``` @testcon.ad_custom_define(acc_id,field_number, field_name, field_type, field_values) ```
    
    Define a custom field for an ad 

``` @testcon.ad_custom_set(acc_id, campaign_id, field_name, field_value)   ```
 
    Set the value of a custom field. For boolean, use yes/no

``` @testcon.call_search(search_options) ```

        search_options = {}
        search_options[:acct_id] Required string. The unique, system-generated account ID of the specified account.

        search_options[:start] Optional (but recommended) strings. The start and end date/time of the search.
        search_options[:end] 

        search_options[:assto] Optional string. The unique, system-generated user ID of the user assigned to the call.

        search_options[:call_boundary] Optional string. Indicates whether to use the start date and time or the end date and time of the call to determine if
        the call is within the dates and times specified in the start and end parameters.

        search_options[:callerid] Optional string. The caller ID.

        search_options[:cmpid] Optional string. The unique, system-generated campaign ID.

        search_options[:dispo] Optional string. A tag added to call(s) in the call log

        search_options[:dna_class] Optional string. The Call DNA classification of the call. (Conversation, Voicemail, Wrong Number, Hold-Time Abandon, IVR/Voicemail Abandon, Ring Transfer Abandon, Unknown)
        
        search_options[:exact_times] Optional boolean. Indicates that the start and end parameters contain a datetime value.
        
        search_options[:extended] Optional string. If not included or false, the response includes only basic information about each call

        search_options[:grpid] Optional string, which can contain up to 16 characters. The unique, system-generated group ID of the ad group
        for the call.

        search_options[:include_dna] Optional boolean. If not included or false, Call DNA information is not returned in the results

        search_options[:include_spotted_keywords] Optional boolean. If not included or false, the "spotted" keywords are not returned in the results.

        search_options[:keyword] Optional string. The keyword or the Custom URL Parameter (if specified in the dynamic tracking rewrite) asso-
        ciated with the call.

        search_options[:min_duration_secs] Optional integer. The minimum number of seconds of the call duration

        search_options[:status] Optional string. The status of the call. ANswer, BUSY, CANCEL or HANGUP, CONGESTION, NOANSWER, NOFORWARDS, VOICEMAIL, WINDDOWN

        search_options[:spotted_keywords] Optional object. If specified, only calls containing one or more of the specified call transcription keywords are
        returned. The spotted_keywords parameter is independent of include_spotted_keywords. agent - Filter the calls based on keywords spoken by the agent. caller - Filter the calls based on keywords spoken by the caller.
            Example:    spotted_keywords =  {}
                        spotted_keywords[:agent] = ['keyword1', 'keyword2', 'keyword3'] 
                        spotted_keywords[:caller] = ['keyword1', 'keyword2', 'keyword']

        search_options[:subacct] Optional boolean. true to search all calls in all client accounts of the specified parent account.

``` @testcon.get_call(call_id) ```

    Return details for a single call

``` @testcon.get_call_audio(call_id, audio_format) ```

    Gets a Base64-encoded string that contains the audio data of the specified call, in the specified format. (mp3 or wav)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mhoskiso/marchex.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

