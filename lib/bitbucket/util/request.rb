module Bitbucket
  module Util
    module Request
      def send_request(url, method, params = {}, timeout = 3)
        request_args = {
            :method => method,
            :headers => header,
            :timeout => timeout}

        full_url = "#{url}"
        if [:get, :delete].include?(method)
          unless full_url.include?("?")
            full_url += "?#{hash_to_query(params)}" 
          else
            full_url += "&#{hash_to_query(params)}"
          end
        else
          # set post body
          request_args[:payload] = params
        end
        # set request url
        request_args[:url] = full_url
        # RestClient::Request.execute(request_args)
        request(request_args)
      end
    end

    # Convert hash to url query
    def hash_to_query(params)
      params_str = ''
      return params_str if params.nil?

      params.each do |k, v|
        params_str += "#{k}=#{v}&"
      end
      params_str.chomp('&')
    end

    def request(options)
      res, req, stat = nil, nil, nil
      begin
        res = ::RestClient::Request.execute(options)
      rescue Exception => e
        # 如果不是请求错误直接抛出标准错误
        unless e.respond_to?("response")
        end
        res = e.response
      end
      begin
        Oj.load(res.body, symbol_keys: true)
      rescue Exception => e
        res.body
      end
    end

    def header
      {Authorization: "Bearer #{access_token}"}
    end
  end
end