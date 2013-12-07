require 'spec_helper'

module ActiveRecord
  module ConnectionAdapters

    describe "created adapter" do
      let(:config) { {} }

      context "creates a postgresql connection" do
        it "creates a postgresql connection" do
          config = {}
          ActiveRecord::Base.should_receive(:postgresql_connection).with(config).and_return { Object.new }

          ActiveRecord::Base.ordered_column_postgresql_connection(config)
        end
      end
    end

    describe OrderedColumnPostgreSQLAdapterWrapper do
      subject { ActiveRecord::Base.ordered_column_postgresql_connection({}) }

      let(:stub_postresql_adapter) { double(PostgreSQLAdapter) }

      before do
        ActiveRecord::Base.stub(:postgresql_connection).and_return { stub_postresql_adapter }
      end

      it "delgates methods to the real postgres adapter" do
        stub_postresql_adapter.should_receive(:table).with('name')

        subject.table('name')
      end

      it "overrides columns and returns the columns sorted by name" do
        stub_postresql_adapter.stub(:columns).and_return([
         TestColumn.new('bbb'),
         TestColumn.new('xb'),
         TestColumn.new('abb'),
         TestColumn.new('aaa')
        ])

        subject.columns('name').should eq [
         TestColumn.new('aaa'),
         TestColumn.new('abb'),
         TestColumn.new('bbb'),
         TestColumn.new('xb')
        ]
      end

      class TestColumn < Struct.new(:name)
      end
    end
  end
end
