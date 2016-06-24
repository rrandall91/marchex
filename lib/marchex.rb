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

      def client_ad_list(client_id)
       response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'ad.list.all', 'params' => [client_id, {'status' => 'active'}]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))

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

  end
end




