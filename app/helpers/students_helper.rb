# Helper methods defined here can be accessed in any controller or view in the application

module GuaraApi
  class App
    module StudentsHelper
      def build_subjects_response_from_sequel(subjects)
        subjects_response = []
        subjects.each do |subject|
          available_space = subject[:quota].to_i - InscriptionsRepository.new.inscriptions_in_course(subject[:id])
          subject_response =
            { codigo: subject[:id],
              nombre: subject[:name],
              docente: subject[:professor],
              modalidad: subject[:type],
              cupo: subject[:quota],
              cupo_disponible: available_space }

          subjects_response.push(subject_response)
        end
        subjects_response
      end

      def build_subjects_response_from_sequel_join(subjects)
        subjects_response = []
        subjects.each do |subject|
          subject_response =
            { codigo: subject[:subject_id],
              nombre: subject[:name],
              docente: subject[:professor] }

          subjects_response.push(subject_response)
        end
        subjects_response
      end

      def quantity_approved_subjects(inscriptions)
        quantity_approved_courses = 0
        inscriptions.each do |i|
          quantity_approved_courses += 1 if i.status == Inscription::APPROVED_CONST
        end
        quantity_approved_courses
      end
    end

    helpers StudentsHelper
  end
end
