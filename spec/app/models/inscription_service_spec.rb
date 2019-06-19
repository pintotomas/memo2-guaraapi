describe InscriptionService do
  subject(:service) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:subject_repository) }
    it { is_expected.to respond_to(:inscriptions_repository) }
  end
end
