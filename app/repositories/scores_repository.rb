class ScoresRepository < BaseRepository
  self.table_name = :scores
  self.model_class = 'Score'

  def find_by_inscription_id(inscription_id)
    inscription = load_collection dataset.where(inscription_id: inscription_id)
    inscription.first
  end

  protected

  def changeset(score)
    {
      inscription_id: score.inscription_id,
      scores: score.scores,
      type_subject: score.type_subject
    }
  end
end
