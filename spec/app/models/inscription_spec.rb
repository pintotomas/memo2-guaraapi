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
      expect(inscription.status).to eq Inscription::APPROVED_CONST
    end

    it 'set_approval_status sets inscription to DESAPRBADO status when false is passed' do
      inscription.approval_status(false)
      expect(inscription.status).to eq Inscription::DISAPPROVED_CONST
    end
  end

  describe 'score' do
    let(:passing_score) do
      Score.new(id: 1, inscription_id: 2, scores: [8, 8, 8],
                type_subject: 'tareas')
    end
    let(:failing_score) do
      Score.new(id: 1, inscription_id: 2, scores: [1, 2, 8],
                type_subject: 'tareas')
    end
    let(:inscription2) do
      described_class.new(student_id: 'leonidas', subject_id: 123, status: Inscription::INSCRIBED)
    end

    it 'sets in_progress to false' do
      inscription2.score(passing_score)
      expect(inscription2.in_progress).to eq false
    end

    it 'sets status and final grade for passing score' do
      inscription2.score(passing_score)
      expect(inscription2.status).to eq Inscription::APPROVED_CONST
      expect(inscription2.final_grade).to eq 8
    end

    it 'sets status and final grade for failing score' do
      inscription2.score(failing_score)
      expect(inscription2.status).to eq Inscription::DISAPPROVED_CONST
      expect(inscription2.final_grade).to eq 1
    end
  end
end
