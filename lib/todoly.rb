
require "json"
require "rest_client"

module Todoly

  class TodolyError < StandardError; end

  TODOLY_API_URL = "https://todo.ly/api/"

  class Client
    def rest_client_with_token(token)
      RestClient::Resource.new(@api_url,
                               :headers => { :Token => token })
    end

    def rest_client_with_password(user, password)
      RestClient::Resource.new(@api_url,
                               :user => user,
                               :password => password)
    end

    {
      :get_token => {
        :path => "authentication/token",
        :method => :get,
        :member => "TokenString",
      },
      :delete_token => {
        :path => "authentication/token",
        :method => :delete,
        :member => "TokenString",
      },
      :projects => {
        :path => "projects",
        :method => :get,
      },
      :items_of_project => {
        :path => "projects/%d/items",
        :method => :get,
      },
      :done_items_of_project => {
        :path => "projects/%d/doneitems",
        :method => :get,
      },
      :filters => {
        :path => "filters",
        :method => :get,
      },
      :items_of_filter => {
        :path => "filters/%d/items",
        :method => :get,
      },
      :items => {
        :path => "items",
        :method => :get,
      },
      :item_by_id => {
        :path => "items/%d",
        :method => :get,
      },
      :create_item => {
        :path => "items",
        :method => :post,
      },
      :delete_item_by_id => {
        :path => "items/%d",
        :method => :delete,
      },
    }.each do |meth, data|
      class_eval do
        define_method(meth) do |*params|
          if /_(?:by|of)_/ =~ meth
            id, param = params
            path = sprintf(data[:path]+".json", id)
          else
            path = data[:path] + ".json"
            param, = params
          end
          if data[:method] == :post
            json = @api[path].send(data[:method], param.to_json)
          else
            json = @api[path].send(data[:method])
          end
          obj = JSON.parse(json)
          if obj.is_a?(Hash) and obj["ErrorMessage"]
            raise TodolyError, obj["ErrorMessage"]
          end
          if data[:member]
            unless obj.include?(data[:member])
              raise TodolyError, "expected member #{data[:member]} is not contained"
            end
            obj = obj[data[:member]]
          end
          obj
        end
      end
    end

    def initialize(opt={})
      if ENV["https_proxy"]
        RestClient.proxy = ENV["https_proxy"]
      elsif ENV["http_proxy"]
        RestClient.proxy = ENV["http_proxy"]
      end
      @api_url = opt[:api_url] || TODOLY_API_URL
      if opt[:token]
        @api = rest_client_with_token(token)
      elsif opt[:email] and opt[:password]
        @api = rest_client_with_password(opt[:email], opt[:password])
        @api = rest_client_with_token(get_token)
      else
        raise "Please specify :email and :password or :token"
      end
    end
  end
end
