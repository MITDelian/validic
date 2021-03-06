# encoding: utf-8

module Validic
  module Sleep

    ##
    # Get Sleep Activities base on `access_token`
    # Default data fetched is from yesterday
    #
    # @params :organization_id - for organization specific
    # @params :user_id - for user specific
    #
    # @params :start_date - optional
    # @params :end_date - optional
    # @params :access_token - override for default access_token
    # @params :source - optional - data per source (e.g 'fitbit')
    # @params :expanded - optional - will show the raw data
    # 
    # @return [Hashie::Mash] with list of Sleep
    def get_sleeps(options={})
      organization_id = options[:organization_id]
      user_id = options[:user_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token],
        source: options[:source],
        expanded: options[:expanded],
        limit: options[:limit],
        page: options[:page],
        offset: options[:offset]
      }

      if organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/sleep.json", options)
      elsif user_id
        response = get("/#{Validic.api_version}/users/#{user_id}/sleep.json", options)
      else
        response = get("/#{Validic.api_version}/sleep.json", options)
      end
      response if response
    end

    ##
    # Create Sleep base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    # 
    # @params :total_sleep
    # @params :awake
    # @params :deep
    # @params :light
    # @params :rem
    # @params :times_woken
    # @params :timestamp
    # @params :source
    #
    # @return success
    def create_sleep(options={})
      options = {
        access_token: options[:access_token],
        sleep: {
          total_sleep: options[:total_sleep],
          awake: options[:awake],
          deep: options[:deep],
          light: options[:light],
          rem: options[:rem],
          times_woken: options[:times_woken],
          timestamp: options[:timestamp],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/sleep.json", options)
      response if response
    end

  end
end
