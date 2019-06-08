# Helper methods defined here can be accessed in any controller or view in the application

module GuaraApi
  class App
    module ProfessorsHelper
      def get_subject_from_json(request_body)
        Subject.new(id: request_body['codigo'], professor: request_body['docente'],
                    name: request_body['nombreMateria'], type: request_body['modalidad'],
                    quota: request_body['cupo'], requires_lab: request_body['laboratorio'],
                    requires_proyector: request_body['proyector'])
      end
    end

    helpers ProfessorsHelper
  end
end
