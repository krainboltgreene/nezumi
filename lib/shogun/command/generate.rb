module Shogun
  class Command
    class Generate
      include Architecture

      def initialize(namespace, resource, *parameters)
        @namespace = namespace
        @resource = resource
        @parameters = parameters

        require "envied"
        require "dotenv"
        Dotenv.load
        ENVied.require
      end

      def execute
        architecture(source: scaffold_directory, destination: namespace_directory) do |architect|
          architect.copy(file: "resource.rb", as: "#{resource}.rb", context: context)
          architect.create(directory: architect.destination(resource))
          architect.within(source: "resource", destination: resource) do |scope|
            scope.copy(file: "endpoint.rb", context: context)
            scope.copy(file: "model.rb", context: context)
            scope.copy(file: "null.rb", context: context)
            scope.copy(file: "presenter.rb", context: context)
            subresource(scope, "show")
            subresource(scope, "list")
            subresource(scope, "create")
            subresource(scope, "update")
            subresource(scope, "destroy")
          end
        end
      end

      private def subresource(architect, name)
        architect.copy(file: "#{name}.rb", context: context)
        architect.create(directory: architect.destination(name))
        architect.within(source: name, destination: name) do |scope|
          scope.copy(file: "authorizer.rb", context: context)
          scope.copy(file: "control.rb", context: context)
          scope.copy(file: "denormalizer.rb", context: context)
          scope.copy(file: "normalizer.rb", context: context)
          scope.copy(file: "validator.rb", context: context)
        end
      end

      private def scaffold_directory
        File.join(gem_directory, "scaffold", "generate")
      end

      private def namespace_directory
        File.join(current_directory, "lib", @namespace)
      end

      private def resource_directory
        destination(@parameters.first)
      end

      private def gem_directory
        Gem::Specification.find_by_name("shogun").gem_dir
      end

      private def current_directory
        Dir.pwd
      end

      private def context
        {
          namespace_module: namespace_module,
          resource_module: resource_module,
          namespace: namespace,
          resource: resource
        }
      end

      private def namespace_module
        @namespace.camelcase
      end

      private def resource_module
        @resource.camelcase
      end

      private def namespace
        @namespace.downcase
      end

      private def resource
        @resource.downcase
      end

      private def resource_singular
        resource.singular
      end
    end
  end
end
