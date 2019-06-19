# Helper methods defined here can be accessed in any controller or view in the application

module GuaraApi
  class App
    module StudentsHelper
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
