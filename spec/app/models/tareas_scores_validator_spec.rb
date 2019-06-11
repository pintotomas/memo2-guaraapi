describe TareasScoresValidator do
  subject(:tareasScoresValidator) { described_class.new }

  it 'should raise error if no scores are scored in tareas' do
    score = Score.new(id: 1, inscription_id: 2, scores: [], type_subject: 'parciales')
    expect { tareasScoresValidator.validate(score) }
      .to raise_error(TareasMustHaveAtLeastOneScoreError)
  end
end
