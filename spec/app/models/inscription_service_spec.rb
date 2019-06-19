describe InscriptionService do
  subject(:service) { described_class.new }

  after(:each) do
    service.inscriptions_repository.delete_all
    service.subject_repository.delete_all
  end

  let(:inscription3) do
    inscription = Inscription.new(student_id: 'Rob1234', subject_id: 123, status: Inscription::INSCRIBED)
    inscription
  end
  let(:inscription2) do
    inscription = Inscription.new(student_id: 'Rob1231', subject_id: 123, status: Inscription::INSCRIBED)
    inscription
  end
  let(:inscription1) do
    inscription = Inscription.new(student_id: 'Rob1232', subject_id: 123, status: Inscription::INSCRIBED)
    inscription
  end
  let(:subject_one) do
    subject_one = Subject.new(name: 'Analisis 3',
                              professor: 'Sirne', id: 123, quota: 2,
                              type: 'coloquio', requires_proyector: true,
                              requires_lab: false)
    subject_one
  end

  describe 'model' do
    it { is_expected.to respond_to(:subject_repository) }
    it { is_expected.to respond_to(:inscriptions_repository) }
  end

  describe 'save' do
    it 'saves when inscriptions' do
      service.subject_repository.save(subject_one)
      service.save(inscription1)
      expect(service.inscriptions_repository.inscriptions_in_course(subject_one.id)).to eq 1
    end

    it 'saves when inscriptions is less than quota' do
      service.subject_repository.save(subject_one)
      service.save(inscription1)
      service.save(inscription2)
      expect(service.inscriptions_repository.inscriptions_in_course(subject_one.id)).to eq 2
    end

    it 'doesnt save when inscriptions amount equals quota and raises ExceededQuotaError' do
      service.subject_repository.save(subject_one)
      service.save(inscription1)
      service.save(inscription2)
      expect { service.save(inscription3) }.to raise_error(ExceededQuotaError)
      expect(service.inscriptions_repository.inscriptions_in_course(subject_one.id)).to eq 2
    end
  end
end
