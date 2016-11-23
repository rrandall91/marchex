require 'bundler/setup'
require "marchex/version"
require "base64"
require 'json'
require 'ostruct'

require 'rest-client'



module Marchex
  class Marchexapi
  

      def initialize(u, p)
        @url = 'https://userapi.voicestar.com/api/jsonrpc/1'
        $auth = 'Basic ' + Base64.encode64(u + ':' + p).chomp      
      end


      def account_list()
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'acct.list', 'params' => [] }.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
        
      end

      def client_ad_list(client_id, status ='')
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'ad.list.all', 'params' => [client_id, {'status' => status.downcase}]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))

      end  
      
      def parse_json(response)
        body = JSON.parse(response.to_str) if response.code == 200
        OpenStruct.new(code: response.code, body: body)
      end

      def ad_forward_list(campaign_id)
       response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'ad.forw.list', 'params' => [campaign_id]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
      end 

      def ad_record_status(campaign_id)
       response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'ad.recordcall.get', 'params' => [campaign_id]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
       return response.body["result"]
      end

      def user_list(account_id)
       response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'user.list', 'params' => [account_id]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
       return response.body["result"]
      end

      def user_permissions(user_id)
       response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'user.permissions.get', 'params' => [user_id]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
       return response.body["result"]
      end

      def ad_custom_define(acc_id,field_number, field_name, field_type, field_values)
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'ad.custom.define', 'params' => [acc_id,field_number, field_name, field_type, field_values]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
       return response.body["result"]
      end

      def ad_custom_set(acc_id, campaign_id, field_name, field_value)
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'ad.custom.set', 'params' => [acc_id,campaign_id, field_name, field_value]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
        return response.body["result"]
      end 

      def call_search ( opts = {})
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'call.search', 'params' => [opts[:acct_id], {'start' => opts[:start_date], 'end' => opts[:end_date]} ]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
        return response.body["result"]
      end

  end
end

 # response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'call.search', 'params' => [opts[:acc_id], :start => {opts[:start], :end => opts[:end], :assto => opts[:assto], :call_boundary => opts[:call_boundary], :callerid => opts[:callerid], :cmpid => opts[:cmpid], :dispo => opts[:dispo], :dna_class => opts[:dna_class], :exact_times => opts[:exact_times], :extended => opts[:extended], :include_spotted_keywords => opts[:include_spotted_keywords], :keyword => opts[:keyword], :min_duration_secs => opts[:min_duration_secs], :spotted_keywords => { :agent => {opts[:agent_keywords]}, :caller => {opts[:caller_keywords]}}, opts[:status], opts[:subacct] }]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))


#{
#"jsonrpc": "2.0",
#"id": 1,
#"method": "call.search",
#"params": [
#"account_id",
#{"start": "string","end": "string","assto": "string","call_boundary": "string","callerid": "string","cmpid": "string","dispo": "string","dna_class": "string","exact_times": boolean,"extended": boolean,"grpid": "string","include_dna": boolean,"include_spotted_keywords": boolean,
#"keyword": "string","min_duration_secs": integer,"spotted_keywords": {"agent": {217["string1", "string2", ... ]},"caller": {["string1", "string2", ... ]}},
#"status": "string",
#"subacct": boolean
#}
#]
#}

