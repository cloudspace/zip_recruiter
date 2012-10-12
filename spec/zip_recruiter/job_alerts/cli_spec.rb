require 'stringio'
require 'spec_helper'
require 'zip_recruiter/job_alerts'
require 'zip_recruiter/job_alerts/cli'

describe ZipRecruiter::JobAlerts::CLI do
  before :each do
    ZipRecruiter::API.api_key = '' # might not need this?
    @jobalerts_cli = ZipRecruiter::JobAlerts::CLI.new
    ZipRecruiter::JobAlerts::API.stub(:subscribe)
    ZipRecruiter::JobAlerts::API.stub(:unsubscribe)
    ZipRecruiter::JobAlerts::API.stub(:status)
  end

  describe "#subscribe" do
    it "raises an exception when called with a bad file path" do
      STDOUT.should_receive(:puts).with("File \"/path/to/bad/file.csv\" does not exist.")
      @jobalerts_cli.subscribe("/path/to/bad/file.csv")
    end

    it "calls the subscribe api method when given a good file path" do
      File.stub(:exists?).and_return(true)
      ZipRecruiter::JobAlerts::API.should_receive(:subscribe).with("/path/to/good/file.csv")
      @jobalerts_cli.subscribe("/path/to/good/file.csv")
    end
  end

  describe "#unsubscribe" do
    it "raises an exception when called with a bad file path" do
      STDOUT.should_receive(:puts).with("File \"/path/to/bad/file.csv\" does not exist.")
      @jobalerts_cli.unsubscribe("/path/to/bad/file.csv")
    end

    it "calls the unsubscribe api method when given a good file path" do
      File.stub(:exists?).and_return(true)
      ZipRecruiter::JobAlerts::API.should_receive(:unsubscribe).with("/path/to/good/file.csv")
      @jobalerts_cli.unsubscribe("/path/to/good/file.csv")
    end
  end

  describe "#status" do
    it "calls the status api method" do
      ZipRecruiter::JobAlerts::API.should_receive(:status).with("foobar")
      @jobalerts_cli.status("foobar")
    end
  end
end
