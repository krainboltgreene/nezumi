module {{namespace_module}}
  module Accounts
    module Show
      require_relative "show/control"
      require_relative "show/denormalizer"
      require_relative "show/normalizer"
      require_relative "show/validator"
    end
  end
end
