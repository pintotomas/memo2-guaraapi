describe InscriptionsRepository do
  let(:repository) { described_class.new }

  let!(:inscription_one) do
    inscription = Inscription.new(id: 1,
                                  student_id: 'Rob123', code: 245, status: 'inscripto')
    inscription
  end

  describe 'find inscription by student and subject id' do
    it 'should raise foreign key constraint violation if subject doesnt exist in database' do
      expect { repository.save(inscription_one) }.to raise_error
      Sequel::ForeignKeyConstraintViolation
    end
  end
end
