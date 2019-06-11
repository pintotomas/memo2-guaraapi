describe ParcialesScoresValidator do
  subject(:parcialesScoresValidator) { described_class.new }

  it 'should raise error if more only one score is scored in parciales' do
    score = Score.new(id: 1, inscription_id: 2, scores: [2], type_subject: 'parciales')
    expect { parcialesScoresValidator.validate(score) }
      .to raise_error(ParcialesMustHaveExactlyTwoScores)
  end
  it 'shouldnt raise error if two scores are scored in parciales' do
    score = Score.new(id: 1, inscription_id: 2, scores: [2, 3], type_subject: 'parciales')
    expect { parcialesScoresValidator.validate(score) }
      .not_to raise_error(ParcialesMustHaveExactlyTwoScores)
  end
end
