if defined?(PhusionPassenger)
  module PhusionPassenger
    module Utils
      protected
      def before_handling_requests_with_pg(forked, options)
        if forked && defined?(::ActiveRecord::Base)
          begin
            if ::ActiveRecord::Base.respond_to?(:connection)
              if ::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::ADAPTER_NAME == ::ActiveRecord::Base.connection.adapter_name
                # Reset all prepared statements, they will be handled properly in donor thread
                ::ActiveRecord::Base.connection.instance_variable_set(:@statements, {})
              end
            end
          rescue Exception => e
            print_exception(self.class.to_s, e)
          end
        end
        before_handling_requests_without_pg(forked, options)
      end
      alias_method_chain :before_handling_requests, :pg
    end
  end
end