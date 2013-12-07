require 'active_record/connection_adapters/postgresql_adapter'

module ActiveRecord
  class Base
    def self.ordered_column_postgresql_connection(config)
      ConnectionAdapters::OrderedColumnPostgreSQLAdapterWrapper.new(postgresql_connection(config))
    end
  end

  module ConnectionAdapters
    class OrderedColumnPostgreSQLAdapterWrapper < Delegator
      def initailize(postgresql_connection)
        super
        @postgresql_connection = postgresql_connection
      end

      def columns(table_name, name = nil)
        @postgresql_connection.columns(table_name, name).sort { |x,y| x.name <=> y.name }
      end

      def __getobj__
        @postgresql_connection
      end

      def __setobj__(obj)
        @postgresql_connection = obj
      end
    end
  end
end
