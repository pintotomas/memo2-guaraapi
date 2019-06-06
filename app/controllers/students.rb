require 'json'

GuaraApi::App.controllers :students do
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
  get :materias, map: '/materias' do
    subjects_response = []
    subjects = SubjectRepository.new.all
    subjects.each do |subject|
      subject_response =
        { codigo: subject[:code],
          materia: subject[:name],
          docente: subject[:professor] }

      subjects_response.push(subject_response)
    end
    { 'oferta' => subjects_response }.to_json
  end
end
