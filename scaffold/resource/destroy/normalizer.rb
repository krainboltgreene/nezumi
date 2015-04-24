module {{namespace_module}}
  module {{resource_module}}
    module Destroy
      class Normalizer
        include Shogun::Normalizer
        include {{resource_module}}

        METADATA = %w|id|

        def initialize(raw:)
          @id = raw["id"]

          if raw["rack.authentication"] && raw["rack.authentication"]["sessions"]
            @session = raw["rack.authentication"]["sessions"]["id"]
          end
        end

        def id
          @id
        end

        def session
          @session
        end
      end
    end
  end
end
