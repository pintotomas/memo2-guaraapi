describe Inscription do
  subject(:inscription) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:student_id) }
    it { is_expected.to respond_to(:subject_id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:final_grade) }
    it { is_expected.to respond_to(:in_progress) }
  end

  describe 'status' do
    it 'set_approval_status sets inscription to APROBADO status when true is passed' do
      inscription.approval_status(true)
      expect(inscription.status).to eq 'APROBADO'
    end

    it 'set_approval_status sets inscription to DESAPRBADO status when false is passed' do
      inscription.approval_status(false)
      expect(inscription.status).to eq 'DESAPROBADO'
    end
  end
end
