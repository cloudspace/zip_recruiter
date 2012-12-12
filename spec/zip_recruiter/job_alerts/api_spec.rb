require 'spec_helper'
require 'zip_recruiter/job_alerts'
require 'zip_recruiter/job_alerts/api'

describe ZipRecruiter::JobAlerts::API do
  before :each do
    @json = mock JSON
    @net_http = mock Net::HTTP
    @net_http_post = mock Net::HTTP::Post
    @net_http_get = mock Net::HTTP::Get
    @net_httpresponse = mock Net::HTTPResponse
    @json.stub(:pretty_generate)
    @json.stub(:load)
    @net_http.stub(:new)
    @net_http.stub(:use_ssl=)
    @net_http.stub(:request)
    @net_http_post.stub(:new)
    @net_http_post.stub(:body=)
    @net_http_post.stub(:content_type=)
    @net_http_post.stub(:basic_auth)
    @net_http_get.stub(:new)
    @net_http_get.stub(:basic_auth)
    @net_httpresponse.stub(:body)
    @file = mock File
    @file.stub(:expand_path)
    @file.stub(:path)
    @file.stub(:read).and_return("")
    @file.stub(:close)
  end

  describe "#perform_action" do
    it "raises an exception when called with an unknown action" do
      lambda { ZipRecruiter::JobAlerts::API.perform_action(:unknown_action, nil) }.should raise_error
    end

    it "works when called with subscribe and a good file path" do
      @file.stub(:exists?).and_return(true)
      @net_http.should_receive(:request)
      @net_httpresponse.should_receive(:body)
      ZipRecruiter::JobAlerts::API.perform_action(:subscribe, '/path/to/good/file.csv')
    end

    it "raises an exception when called with subscribe and a bad file path" do
      @file.stub(:exists?).and_return(false)
      lambda { ZipRecruiter::JobAlerts::API.perform_action(:subscribe, "/path/to/bad/file.csv") }.should raise_error
    end

    it "works when called with unsubscribe and a good file path" do
      @file.stub(:exists?).and_return(true)
      @net_http.should_receive(:request)
      @net_httpresponse.should_receive(:body)
      ZipRecruiter::JobAlerts::API.perform_action(:unsubscribe, '/path/to/good/file.csv')
    end

    it "raises an exception when called with unsubscribe and a bad file path" do
      @file.stub(:exists?).and_return(false)
      lambda { ZipRecruiter::JobAlerts::API.perform_action(:unsubscribe, "/path/to/bad/file.csv") }.should raise_error
    end

    it "works when called with status and a string argument" do
      @net_http.should_receive(:request)
      @net_httpresponse.should_receive(:body)
      ZipRecruiter::JobAlerts::API.perform_action(:status, "foobar")
    end
  end

  describe "#subscribe" do
    it "calls perform_action subscribe with the correct argument" do
      ZipRecruiter::JobAlerts::API.should_receive(:perform_action).with(:subscribe, "the path")
      ZipRecruiter::JobAlerts::API.subscribe("the path")
    end
  end

  describe "#unsubscribe" do
    it "calls perform_action unsubscribe with the correct argument" do
      ZipRecruiter::JobAlerts::API.should_receive(:perform_action).with(:unsubscribe, "the path")
      ZipRecruiter::JobAlerts::API.unsubscribe("the path")
    end
  end

  describe "#status" do
    it "calls perform_action status with the correct argument" do
      ZipRecruiter::JobAlerts::API.should_receive(:perform_action).with(:status, "the task id")
      ZipRecruiter::JobAlerts::API.status("the task id")
    end
  end
end
