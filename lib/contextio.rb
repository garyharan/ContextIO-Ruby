require 'oauth'
require 'net/http'

module ContextIO
  VERSION = "1.0"

  class ContextIO::Connection
    def initialize(key='', secret='', server='https://api.context.io')
      @consumer = OAuth::Consumer.new(key, secret, {:site => server, :sheme => :header})
      @token    = OAuth::AccessToken.new @consumer
    end

    def all_messages(options)
      get 'allmessages', {:limit => 10, :since => 0}.merge(options)
    end

    def all_files(options)
      get 'allfiles', {:since => 0}.merge(options)
    end

    def contact_files(options)
      get 'contactfiles', options
    end

    def contact_messages(options)
      get 'contactmessages', options
    end

    def diff_summary(options)
      get 'diffsummary', options
    end

    def file_search(options)
      get 'filesearch', options
    end

    def message_info(options)
      get 'messageinfo', options
    end

    def message_text(options)
      get 'messagetext', options
    end

    def related_files(options)
      get 'relatedfiles', options
    end

    def thread_info(options)
      get 'threadinfo', options
    end

    def discover(options)
      get 'imap/discover', options
    end

    def add_account(options)
      get 'imap/addaccount', options
    end

    def modify_account(options)
      get 'imap/modifyaccount', options
    end

    def remove_account
      get 'imap/removeaccount'
    end

    def reset_status
      get 'imap/resetstatus'
    end

    def download_file(options)
      @token.get "/#{ContextIO::VERSION}/downloadfile?#{parametrize options}"
    end

    private

    def url(*args)
      if args.length == 1
        "/#{ContextIO::VERSION}/#{args[0]}.json"
      else
        "/#{ContextIO::VERSION}/#{args.shift.to_s}.json?#{parametrize args.last}"
      end
    end

    def get(*args)
      @token.get(url(*args), "Accept" => "application/json").body
    end

    def parametrize(options)
      URI.escape(options.collect do |k,v|
        v = v.to_i if k == :since
        v = v.join(',') if v.instance_of?(Array)
        k = k.to_s.gsub('_', '')
        "#{k}=#{v}"
      end.join('&'))
    end
  end
end
