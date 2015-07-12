require 'spec_helper'

describe Parker::Announcement do
  subject { described_class.new }
  let(:issue) { double(html_url: 'http://www.example.com', number: '3124', title: 'It broke', created_at: Time.now - 432_000) }
  describe '#p1_announcement' do
    let(:p1s) { [issue] }
    it 'returns a string containing the count of P1 issues' do
      expect(subject.p1_announcement).to include('1')
    end
  end
  describe '#p2_announcement' do
    let(:p2s) { [issue] }
    it 'returns a string containing the count of P1 issues' do
      expect(subject.p2_announcement).to include('1')
    end
  end
end
