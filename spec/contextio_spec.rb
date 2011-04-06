require_relative '../lib/contextio.rb'
require 'minitest/autorun'
require 'mocha'
require 'ruby-debug'

describe ContextIO::Connection do
  before do
    @key           = 'iakg19tj'
    @secret        = '4n4mIpQTvQoxyF2s'
    @account       = 'gary.haran@gmail.com'
    @five_days_ago = (Time.now - 24 * 60 * 60 * 5).to_i

    @connection = ContextIO::Connection.new(@key, @secret)
  end

  it "should call allfiles.json" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/allfiles.json?since=#{@five_days_ago}&account=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    files = @connection.all_files(:account => @account, :since => @five_days_ago)
  end

  it "should call allmessage.json" do
    since = Time.now - 24 * 60 * 60 * 5
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/allmessages.json?limit=1&since=#{@five_days_ago}&account=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.all_messages(:account => @account, :limit => 1, :since => @five_days_ago)
  end

  it "should call reflect limit" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/allmessages.json?limit=10&since=#{@five_days_ago}&account=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.all_messages(:account => @account, :limit => 10, :since => @five_days_ago)
  end

  it "should call contactfiles.json" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/contactfiles.json?account=#{@account}&email=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.contact_files(:account => @account, :email => @account)
  end

  it "should call contactmessages.json" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/contactmessages.json?account=#{@account}&email=#{@account}&cc=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    messages = @connection.contact_messages(:account => @account, :email => @account, :cc => @account)
  end

  it "should allow multile emails" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/contactmessages.json?account=#{@account}&email=#{@account},#{@account}&cc=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.contact_messages(:account => @account, :email => [@account, @account], :cc => @account)
  end

  it "should call diffsummary.json" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/diffsummary.json?account=#{@account}&fileid1=1&fileid2=2&generate=1", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.diff_summary(:account => @account, :fileid1 => 1, :fileid2 => 2, :generate => 1)
  end

  it "should call filesearch.json" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/filesearch.json?account=#{@account}&filename=proposal", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.file_search(:account => @account, :filename => 'proposal')
  end

  it "should call messageinfo.json" do
    message_id = "1234567890"
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/messageinfo.json?account=#{@account}&emailmessageid=#{message_id}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.message_info(:account => @account, :email_message_id => message_id)
  end

  it "should allow date sent and from as options" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/messageinfo.json?account=#{@account}&datesent=#{@five_days_ago}&from=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.message_info(:account => @account, :date_sent => @five_days_ago, :from => @account)
  end

  it "should call messagetext.json" do
    message_id = "1234567890"
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/messagetext.json?account=#{@account}&emailmessageid=#{message_id}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.message_text(:account => @account, :email_message_id => message_id)
  end

  it "should allow date sent and from as parameters" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/messagetext.json?account=#{@account}&datesent=#{@five_days_ago}&from=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.message_text(:account => @account, :date_sent => @five_days_ago, :from => @account)
  end
  
  it "should call relatedfiles.json" do
    file_id = "1234567890"
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/relatedfiles.json?account=#{@account}&fileid=#{file_id}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.related_files(:account => @account, :file_id => file_id)
  end

  it "should allow file_name as a parameter" do
    file_name = "proposal"
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/relatedfiles.json?account=#{@account}&filename=#{file_name}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.related_files(:account => @account, :file_name => file_name)
  end

  it "should call threadinfo.json with proper params" do
    gmail_thread_id = '12f22faa06d1394f'
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/threadinfo.json?account=#{@account}&gmailthreadid=#{gmail_thread_id}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.thread_info(:account => @account, :gmail_thread_id => gmail_thread_id)
  end

  it "should call discover with proper params" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/imap/discover.json?email=#{@account}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.discover(:email => @account)
  end

  it "should call proper url for add account" do
    server   = 'imap.gmail.com'
    username = 'john'
    password = 'us3rpa44'
    use_ssl  = 1
    port     = 993
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/imap/addaccount.json?email=#{@account}&server=#{server}&username=#{username}&password=#{password}&usessl=1&port=#{port}", 
                "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.add_account(:email => @account, :server => server, :user_name => username, :password => password, :use_ssl => 1, :port => port)
  end

  it "should call proper url for modify account" do
    credentials = 'us3rpa44'
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/imap/modifyaccount.json?credentials=#{credentials}", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.modify_account(:credentials => credentials)
  end

  it "should call proper url for remove account" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/imap/removeaccount.json", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.remove_account
  end

  it "should call proper url for reset status" do
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/imap/resetstatus.json", "Accept" => "application/json")
          .returns(stub(:body => '{"data": {}}'))
    @connection.reset_status
  end

  it "should download file" do
    file_id = '4d9a806a1d9362da5b111114'
    OAuth::AccessToken.any_instance.expects(:get).once
          .with("/1.0/downloadfile?fileid=#{file_id}")
    @connection.download_file(:file_id => file_id)
  end

  it "should search with regular expressions"
end
