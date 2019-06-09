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
end
