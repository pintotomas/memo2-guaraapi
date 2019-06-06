GuaraApi::App.controllers :professors do
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  post :materias, map: '/materias' do
    request_body = JSON.parse(request.body.read.to_s)
    @subject = get_subject_from_json(request_body)
    SubjectRepository.new.save(@subject)
    status 201
    { "resultado": 'materia_creada' }.to_json
  end
end
