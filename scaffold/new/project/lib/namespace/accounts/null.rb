module {{namespace_module}}
  module Accounts
    class Null
      attr_reader :password

      def initialize
        @password = nil
      end
    end
  end
end
