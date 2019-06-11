GuaraApi::App.controllers :professors do
  before do
    halt 401 unless valid_api_key?(request.env['HTTP_API_TOKEN'])
  end
  post :materias, map: '/materias' do
    request_body = JSON.parse(request.body.read.to_s)
    @subject = get_subject_from_json(request_body)
    SubjectRepository.new.save(@subject)
    if @subject.valid?
      status 201
      { "resultado": 'materia_creada' }.to_json
    else
      status 500
    end
  end

  post :calificar, map: '/calificar' do
    content = request.body.read
    request_body = JSON.parse(content.gsub('\"', '"'))
    inscription = InscriptionsRepository.new.find_by_student_and_subject_id(
      request_body['username_alumno'], request_body['codigo_materia']
    )
    if inscription.nil?
      status 500
      body 'El alumno no esta inscripto'
      return
    end
    score = Score.new(inscription_id: inscription.id, scores: [1], type_subject: 'coloquio')
    if score.valid?
      final_score = Scorer.new.calculate_final_score(score)
      inscription.status = inscription.approval_status(final_score.passed_course)
      inscription.final_grade = final_score.score
      InscriptionsRepository.new.save(inscription)
      status 201
      body 'Calificacion exitosa'
    else
      status 500
      body 'Fallo calificacion'
    end
  rescue Sequel::ForeignKeyConstraintViolation
    status 500
  end
end
