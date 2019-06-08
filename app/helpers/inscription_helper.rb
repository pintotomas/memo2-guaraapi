# Helper methods defined here can be accessed in any controller or view in the application

module GuaraApi
  class App
    module InscriptionHelper
      def get_inscription_from_json(request_body)
        Inscription.new(subject_id: request_body['codigo_materia'],
                        student_id: request_body['username_alumno'],
                        status: 'Inscripto')
      end
    end

    helpers InscriptionHelper
  end
end
