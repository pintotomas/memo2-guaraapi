GuaraApi::App.controllers :health do
  get :index do
    ping = Ping.create(description: 'health-controller')
    if ping.nil?
      status 500
    else
      status 200
      'ok'
    end
  end

  get :stats, provides: [:json] do
    { subjects_count: Subject.count }.to_json
  end

  get :version do
    Version.current
  end

  post :reset, map: '/reset' do
    ScoresRepository.new.delete_all
    InscriptionsRepository.new.delete_all
    SubjectRepository.new.delete_all

    'ok'
  end
end
