GuaraApi::App.controllers :professors do
  UNIQUE_VIOLATION_ERROR_CONST = 'MATERIA_DUPLICADA'.freeze
  SUCCESSFULLY_SCORED_CONST = 'notas_creadas'.freeze
  CREATED_SUBJECT_MSG_CONST = 'MATERIA_CREADA'.freeze
  INVALID_SCORE = 'NOTA_INVALIDA'.freeze
  before do
    halt 401 unless valid_api_key?(request.env['HTTP_API_TOKEN'])
  end
  post :materias, map: '/materias' do
    request_body = JSON.parse(request.body.read.to_s)
    @subject = get_subject_from_json(request_body)
    SubjectRepository.new.insert_subject(@subject)
    if @subject.valid?
      status 201
      { "resultado": CREATED_SUBJECT_MSG_CONST }.to_json
    else
      status 400
      { "error": @subject.errors.messages.values[0][0] }.to_json
    end
  rescue Sequel::UniqueConstraintViolation
    status 400
    { "error": UNIQUE_VIOLATION_ERROR_CONST }.to_json
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
      begin
        grades = JSON.parse(request_body['notas'])
      rescue JSON::ParserError
        status 400
        return { "error": INVALID_SCORE }.to_json
      end
      score = Score.new(inscription_id: inscription.id, scores: grades,
                        type_subject: subject_type)
      if score.valid?
        inscription.score(score)
        InscriptionsRepository.new.save(inscription)
        ScoresRepository.new.save(score)
        status 200
        { "resultado": SUCCESSFULLY_SCORED_CONST }.to_json
      else
        status 400
        { "error": score.errors.messages.values[0][0] }.to_json
      end
    end

  rescue Sequel::ForeignKeyConstraintViolation
    status 500
  end
end
