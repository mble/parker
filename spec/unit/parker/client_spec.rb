require 'spec_helper'

describe Parker::Client do
  subject { described_class }
  describe '.github' do
    it 'creates an Octokit::Client' do
      expect(subject.github).to be_kind_of Octokit::Client
    end
    it 'correctly memoizses the client' do
      expect(subject.github).to eq(subject.github)
    end
  end
  describe '.hipchat' do
    it 'creates a Hipchat::Client' do
      expect(subject.hipchat).to be_kind_of HipChat::Client
    end
    it 'correctly memoizses the client' do
      expect(subject.hipchat).to eq(subject.hipchat)
    end
  end
end
