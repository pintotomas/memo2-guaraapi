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
      { "resultado": 'MATERIA_CREADA' }.to_json
    else
      status 400
      { "error": @subject.errors.messages.values[0][0] }.to_json
    end
  end

  post :calificar, map: '/calificar' do
    request_body = JSON.parse(request.body.read.gsub('\"', '"'))
    inscription = InscriptionsRepository.new.find_by_student_and_subject_id(
      request_body['username_alumno'], request_body['codigo_materia']
    )
    subject_type = SubjectRepository.new.find(request_body['codigo_materia']).type
    if inscription.nil? || !inscription.in_progress
      status 400
      body 'El alumno no esta inscripto'
    else
      body_grades = request_body['notas']
      grades = if body_grades.scan(/\D/).empty?
                 [body_grades.to_i]
               else
                 JSON.parse(request_body['notas'])
               end
      score = Score.new(inscription_id: inscription.id, scores: grades,
                        type_subject: subject_type)
      inscription.score(score)
      InscriptionsRepository.new.save(inscription)
      ScoresRepository.new.save(score)
      if score.valid?
        status 201
        body 'Calificacion exitosa'
      else
        status 400
        body 'Fallo la calificacion'
      end
    end

  rescue Sequel::ForeignKeyConstraintViolation
    status 500
  end
end
