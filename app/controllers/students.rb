require 'json'
REQUIRED_USER_NAME = 'DEBE TENER USER_NAME PARA CONSULTAR'.freeze
REQUIRED_FULL_NAME = 'DEBE TENER NOMBRE Y APELLIDO PARA CONSULTAR'.freeze

GuaraApi::App.controllers :students do
  before do
    halt 401, { 'error' => 'API_TOKEN_INVALIDO' }.to_json unless valid_api_key?(request.env['HTTP_API_TOKEN'])
  end

  get :materias, map: '/materias/all' do
    subjects = SubjectRepository.new.all.all
    status 200
    { "materias": subjects }.to_json
  end

  get :materias, map: '/materias' do
    alias_name = request.params['usernameAlumno']
    if request.params['usernameAlumno'].nil?
      status 400
      { "error": REQUIRED_USER_NAME }.to_json
    else
      subjects = InscriptionsRepository.new.inscribed_subjects_not_approbed(alias_name)
      subjects_response = build_subjects_response_from_sequel(subjects)
      { 'oferta' => subjects_response }.to_json
    end
  end

  get :estado, map: '/materias/estado' do
    alias_name = request.params['usernameAlumno']
    subject_id = request.params['codigoMateria']
    if request.params['usernameAlumno'].nil?
      status 400
      { "error": REQUIRED_USER_NAME }.to_json
    else
      inscription = InscriptionsRepository.new.find_by_student_and_subject_id(alias_name, subject_id)
      inscription_status = 'NO_INSCRIPTO'
      final_grade = nil
      inscription_status = inscription.status if inscription
      final_grade = inscription.final_grade if inscription
      status 200
      { 'estado' => inscription_status, 'nota_final' => final_grade }.to_json
    end
  end

  get :estado, map: '/inscripciones' do
    alias_name = request.params['usernameAlumno']
    if request.params['usernameAlumno'].nil?
      status 400
      { "error": REQUIRED_USER_NAME }.to_json
    else

      subjects = InscriptionsRepository.new.my_inscribed_inscriptions(alias_name)
      inscribed_subjects = build_subjects_response_from_sequel_join(subjects)
      status 200
      { 'inscripciones' => inscribed_subjects }.to_json
    end
  end

  get :promedio, map: '/alumnos/promedio' do
    alias_name = request.params['usernameAlumno']
    inscriptions = InscriptionsRepository.new.find_by_student(alias_name)
    quantity_approved = quantity_approved_subjects(inscriptions)
    average = Scorer.new.calculate_historical_average(inscriptions) || nil
    status 200
    { "materias_aprobadas": quantity_approved, "nota_promedio": average }.to_json
  end

  post :alumnos, map: '/alumnos' do
    request_body = JSON.parse(request.body.read.gsub('\"', '"'))
    inscribed = InscriptionsRepository.new.find_by_student_and_subject_id_and_in_progress(
      request_body['username_alumno'], request_body['codigo_materia']
    )
    begin
      raise DuplicateInscriptionError unless inscribed.nil?

      @inscription = get_inscription_from_json(request_body)
      raise InvalidInscriptionError unless @inscription.valid?

      InscriptionService.new.save(@inscription) # manejar inscribirse a materias inexistentes
      status 201
      { 'resultado' => Inscription::SUCCESSFUL_INSCRIPTION }.to_json
    rescue InscriptionError => e
      status 400
      { "error": e.message }.to_json
    end
  end
end
