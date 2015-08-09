require 'spec_helper'

describe Parker::Client do
  subject { described_class.new }
  describe '#github' do
    it 'creates an Octokit::Client' do
      expect(subject.github).to be_kind_of Octokit::Client
    end
    it 'correctly memoizses the client' do
      expect(subject.github).to eq(subject.github)
    end
  end
  describe '#hipchat' do
    it 'creates a Hipchat::Client' do
      expect(subject.hipchat).to be_kind_of HipChat::Client
    end
    it 'correctly memoizses the client' do
      expect(subject.hipchat).to eq(subject.hipchat)
    end
  end
  describe '#slack' do
    it 'creates a Slack::Web::Client' do
      expect(subject.slack).to be_kind_of Slack::Web::Client
    end
    it 'correctly memoizses the client' do
      expect(subject.slack).to eq(subject.slack)
    end
  end
end
