require 'json'

GuaraApi::App.controllers :students do
  before do
    halt 401, 'API_TOKEN_INVALIDO' unless valid_api_key?(request.env['HTTP_API_TOKEN'])
  end
  get :materias, map: '/materias' do
    subjects_response = []
    subjects = SubjectRepository.new.all
    subjects.each do |subject|
      subject_response =
        { codigo: subject[:id],
          materia: subject[:name],
          docente: subject[:professor] }

      subjects_response.push(subject_response)
    end
    { 'oferta' => subjects_response }.to_json
  end

  get :estado, map: '/materias/estado' do
    alias_name = request.params['usernameAlumno']
    subject_id = request.params['codigoMateria']
    inscription = InscriptionsRepository.new.find_by_student_and_subject_id(alias_name, subject_id)
    inscription_status = 'NO_INSCRIPTO'
    final_grade = nil
    inscription_status = inscription.status if inscription
    final_grade = inscription.final_grade if inscription
    status 200
    { 'estado' => inscription_status, 'nota_final' => final_grade }.to_json
  end

  get :estado, map: '/misinscripciones' do
    alias_name = request.params['usernameAlumno']
    inscribed_subjects = []
    subjects = InscriptionsRepository.new.my_inscribed_inscriptions(alias_name)
    subjects.each do |subject|
      subject_response =
        { codigo: subject[:subject_id],
          materia: subject[:name],
          docente: subject[:professor] }
      inscribed_subjects.push(subject_response)
    end
    status 200
    { 'oferta' => inscribed_subjects }.to_json
  end

  post :alumnos, map: '/alumnos' do
    request_body = JSON.parse(request.body.read.gsub('\"', '"'))
    inscribed = InscriptionsRepository.new.find_by_student_and_subject_id(
      request_body['username_alumno'], request_body['codigo_materia']
    )
    if !inscribed.nil? && inscribed.in_progress
      status 400
      body 'Ya se encuentra inscripto'
      return
    end

    @inscription = get_inscription_from_json(request_body)
    if @inscription.valid?
      InscriptionsRepository.new.save(@inscription) # manejar inscribirse a materias inexistentes
      status 201
      body 'Inscripción exitosa'
    else
      status 500
    end
  rescue Sequel::ForeignKeyConstraintViolation
    status 500
  end
end
