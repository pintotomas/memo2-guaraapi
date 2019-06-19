# Helper methods defined here can be accessed in any controller or view in the application

module GuaraApi
  class App
    module StudentsHelper
      def quantity_approved_subjects(_subjects)
        0
      end
    end

    helpers StudentsHelper
  end
end
