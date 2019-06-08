GuaraApi::App.controllers :inscription do
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
