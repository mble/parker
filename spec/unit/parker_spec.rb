require 'spec_helper'

describe Parker do
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
  describe '#open_for_days' do
    let(:issue) { double(created_at: Time.now - 432_000) } # 5 days ago
    it 'returns the number of days the issue is open for' do
      expect(subject.open_for_days(issue)).to eq(5)
    end
  end
  describe '#issues_info' do
    let(:issues) { [issue] }
    let(:issue)  { double(html_url: 'http://www.example.com', number: '3124', title: 'It broke', created_at: Time.now - 432_000) }
    it 'returns a string containing the url of an issue' do
      expect(subject.issues_info(issues)).to include('http://www.example.com')
    end
    it 'returns a string containing the number of an issue' do
      expect(subject.issues_info(issues)).to include('3124')
    end
    it 'returns a string containing the title of an issue' do
      expect(subject.issues_info(issues)).to include('It broke')
    end
    it 'returns a string containing the number of days an issue has been open for' do
      expect(subject.issues_info(issues)).to include('5')
    end
  end
end
