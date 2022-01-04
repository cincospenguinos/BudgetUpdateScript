require 'csv'

module BudgetUpdateScript
  class TransactionExtraction
    attr_reader :date
    attr_reader :category
    attr_reader :amount
    attr_reader :description

    def initialize(row)
      @row_data = row
      @date = extract_field('Date')
      @amount = extract_field('Amount')
      @description = extract_field('Description')

      @category = ''
      @category = 'Income' if @amount > 0
    end

    def self.extract_from(transaction_string)
      data = CSV.parse(transaction_string)
      @@fields = data.first
      data[1...(data.size)].map { |row| TransactionExtraction.new(row) }
    end

    private

    def extract_field(field_name)
      idx = @@fields.index(field_name)
      case field_name
      when 'Date'
        Date.strptime(@row_data[idx], "%m/%d/%Y")
      when 'Amount'
        idx = @@fields.index('Debit')
        idx = @@fields.index('Credit') if @row_data[idx].empty?
        @row_data[idx].to_f
      else
        @row_data[idx]
      end
    end
  end
end