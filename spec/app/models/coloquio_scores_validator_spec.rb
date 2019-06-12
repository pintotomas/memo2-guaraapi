describe ColoquioScoresValidator do
  subject(:coloquioScoreValidator) { described_class.new }

  it 'should raise error if more than one score is scored in coloquio' do
    score = Score.new(id: 1, inscription_id: 2, scores: [5, 2], type_subject: 'coloquio')
    expect { coloquioScoreValidator.validate(score) }
      .to raise_error(ColoquioScoreHasToBePresentAndUniqueError)
  end
end
