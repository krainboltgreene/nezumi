module {{namespace_module}}
  module Accounts
    module Update
      class Authorizer
        include Accounts
        include Shogun::Authorizer

        def initialize(requester:, resource:)
          if requester
            @requester = requester.account
          end
          @resource = resource
        end

        def allowed?
          @requester == @resource
        end
      end
    end
  end
end
