require "budget_update_script/version"
require "budget_update_script/transaction_extraction"

module BudgetUpdateScript
  def self.convert(csv_string)
    transaction_strings = TransactionExtraction.extract_from(csv_string)
      .map { |t| t.to_csv }
      .join("\n")
  end
end