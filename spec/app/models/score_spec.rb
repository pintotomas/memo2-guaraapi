describe Score do
  subject(:Score) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:inscription_id) }
    it { is_expected.to respond_to(:scores) }
    it { is_expected.to respond_to(:type_subject) }
  end
end
