require 'spec_helper'
describe Parker::Issue do
  subject { described_class.new }
  let(:issue) { double(html_url: 'http://www.example.com', number: '3124', title: 'It broke', created_at: Time.now - 432_000) }
  describe '#open_for_days' do
    it 'returns the number of days the issue is open for' do
      expect(subject.send(:open_for_days, issue)).to eq(5)
    end
  end
  describe '#hipchat_issues_info' do
    let(:issues) { [issue] }
    it 'returns a string containing the url of an issue' do
      expect(subject.hipchat_issues_info(issues)).to include('http://www.example.com')
    end
    it 'returns a string containing the number of an issue' do
      expect(subject.hipchat_issues_info(issues)).to include('3124')
    end
    it 'returns a string containing the title of an issue' do
      expect(subject.hipchat_issues_info(issues)).to include('It broke')
    end
    it 'returns a string containing the number of days an issue has been open for' do
      expect(subject.hipchat_issues_info(issues)).to include('5')
    end
  end
end
