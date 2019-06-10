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

  post :alumnos, map: '/alumnos' do
    content = request.body.read
    request_body = JSON.parse(content.gsub('\"', '"'))
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
