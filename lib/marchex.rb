require 'bundler/setup'
require "marchex/version"
require "base64"
require 'json'
require 'ostruct'

require 'rest-client'



module Marchex
  class Marchexapi

      #RestClient.log = 'stdout' #Debugging API calls

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
        search_options = {}
        search_options[:start] = opts[:start] if opts[:start] 
        search_options[:end] = opts[:end] if opts[:end]
        search_options[:assto] = opts[:assto] if opts[:assto]
        search_options[:call_boundary] = opts[:call_boundary] if opts[:call_boundary]
        search_options[:callerid] = opts[:callerid] if opts[:callerid]
        search_options[:cmpid] = opts[:cmpid] if opts[:cmpid]
        search_options[:dispo] = opts[:dispo] if opts[:dispo]
        search_options[:dna_class] = opts[:dna_class] if opts[:dna_class]
        search_options[:exact_times] = opts[:exact_times] if opts[:exact_times]
        search_options[:extended] = opts[:extended] if opts[:extended]
        search_options[:exact_times] = true if opts[:extended] == true
        search_options[:grpid] = opts[:grpid] if opts[:grpid]
        search_options[:include_dna] = opts[:include_dna] if opts[:include_dna]
        search_options[:include_spotted_keywords] = opts[:include_spotted_keywords] if opts[:include_spotted_keywords]
        search_options[:keyword] = opts[:keyword] if opts[:keyword]
        search_options[:min_duration_secs] = opts[:min_duration_secs] if opts[:min_duration_secs]
        search_options[:status] = opts[:status] if opts[:status]
        search_options[:spotted_keywords] = opts[:spotted_keywords] if opts[:spotted_keywords]
        search_options[:subacct] = opts[:subacct] if opts[:subacct]
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'call.search', 'params' => [opts[:acct_id], search_options ]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
        return response.body["result"]
      end

      def get_call (call_id)      
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'call.get', 'params' => [call_id]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
        return response.body["result"]
      end

      def get_call_audio(call_id, audio_format)
        response = parse_json(RestClient.post(@url, {'jsonrpc' => '2.0', 'id' => '1', 'method' => 'call.audio', 'params' => [call_id, audio_format]}.to_json, :content_type => 'application/json', :accept => 'application/json', :Authorization => $auth))
        return response.body["result"]
      end

  end
end
