require 'json'

GuaraApi::App.controllers :students do
  before do
    halt 401 unless valid_api_key?(request.env['HTTP_API_TOKEN'])
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

  get :miEstado, map: '/miEstado' do
    request_body = JSON.parse(request.body.read.gsub('\"', '"'))
    alias_name = request_body['username_alumno']
    subject_id = request_body['codigo_materia']
    inscribed = InscriptionsRepository.new.find_by_student_and_subject_id(alias_name, subject_id)
    status 201
    body inscribed.status
    return
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
