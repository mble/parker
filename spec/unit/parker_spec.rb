require 'spec_helper'

describe Parker do
  subject { described_class }
  describe '#open_for_days' do
    let(:issue) { double(created_at: Time.now - 432_000) } # 5 days ago
    it 'returns the number of days the issue is open for' do
      expect(subject.open_for_days(issue)).to eq(5)
    end
  end
end
