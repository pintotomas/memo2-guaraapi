describe Inscription do
  subject(:inscription) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:student_id) }
    it { is_expected.to respond_to(:subject_id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:final_grade) }
  end
end
