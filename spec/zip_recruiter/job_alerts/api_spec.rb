require 'spec_helper'
require 'zip_recruiter/job_alerts'
require 'zip_recruiter/job_alerts/api'

describe ZipRecruiter::JobAlerts::API do
  before :each do
    ZipRecruiter::API.api_key = '' # might not need this?
    @curl_easy = mock Curl::Easy
    Curl::Easy.stub(:new).and_return(@curl_easy)
    Curl::PostField.stub(:file)
    @curl_easy.stub(:http_auth_types=)
    @curl_easy.stub(:userpwd=)
    @curl_easy.stub(:url).and_return("")
    @curl_easy.stub(:url=)
    @curl_easy.stub(:multipart_form_post=)
    @curl_easy.stub(:http_post)
    @curl_easy.stub(:perform)
    @curl_easy.stub(:body_str)
  end

  describe "#perform_action" do
    it "raises an exception when called with an unknown action" do
      lambda { ZipRecruiter::JobAlerts::API.perform_action(:unknown_action, nil) }.should raise_error
    end

    it "works when called with subscribe and a good file path" do
      File.stub(:exists?).and_return(true) # pretend the file exists
      @curl_easy.should_receive(:http_post)
      @curl_easy.should_receive(:body_str)
      ZipRecruiter::JobAlerts::API.perform_action(:subscribe, '/path/to/good/file.csv')
    end

    it "raises an exception when called with subscribe and a bad file path" do
      File.stub(:exists?).and_return(false) # pretend the file does not exist
      lambda { ZipRecruiter::JobAlerts::API.perform_action(:subscribe, "/path/to/bad/file.csv") }.should raise_error
    end

    it "works when called with unsubscribe and a good file path" do
      File.stub(:exists?).and_return(true) # pretend the file exists
      @curl_easy.should_receive(:http_post)
      @curl_easy.should_receive(:body_str)
      ZipRecruiter::JobAlerts::API.perform_action(:unsubscribe, '/path/to/good/file.csv')
    end

    it "raises an exception when called with unsubscribe and a bad file path" do
      File.stub(:exists?).and_return(false) # pretend the file does not exist
      lambda { ZipRecruiter::JobAlerts::API.perform_action(:unsubscribe, "/path/to/bad/file.csv") }.should raise_error
    end

    it "works when called with status and a string argument" do
      @curl_easy.should_receive(:perform)
      @curl_easy.should_receive(:body_str)
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
