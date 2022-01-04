require "test_helper"
require 'csv'

class BudgetUpdateScriptTest < Minitest::Test

  SINGLE_TRANSACTION = <<~transaction
    "Date","Account","Description","Category","Check","Credit","Debit"
    "01/24/2020","Anytime Checking","2449215D7MJG4NP36 SQ *BLACKS SLIDERS, SALT LAKE CIT UT","Uncategorized Expense","","","-14.23"
  transaction

  INCOME_TRANSACTION = <<~transaction
    "Date","Account","Description","Category","Check","Credit","Debit"
    "01/24/2020","Anytime Checking","Big Flaming Turds R Us","Uncategorized Expense","","100",""
  transaction

  TWO_TRANSACTIONS = <<~transaction
    "Date","Account","Description","Category","Check","Credit","Debit"
    "01/25/2020","Anytime Checking","Big Flaming Turds R Us","Uncategorized Expense","","100",""
    "01/24/2020","Anytime Checking","2449215D7MJG4NP36 SQ *BLACKS SLIDERS, SALT LAKE CIT UT","Uncategorized Expense","","","-14.23"
  transaction

  END_RESULT = <<~res
  01/24/2020,2449215D7MJG4NP36 SQ *BLACKS SLIDERS, SALT LAKE CIT UT,-14.23,
  01/25/2020,Big Flaming Turds R Us,100.0,Income
  res

  def test_transaction_extraction_works_properly
    transactions = BudgetUpdateScript::TransactionExtraction.extract_from(SINGLE_TRANSACTION)
    assert_equal 1, transactions.size
  end

  def test_transaction_extraction_handles_fields
    transaction = BudgetUpdateScript::TransactionExtraction.extract_from(SINGLE_TRANSACTION).first

    assert_equal  Date.strptime("01/24/2020", "%m/%d/%Y"), transaction.date
    assert_equal '', transaction.category
    assert_equal (-14.23), transaction.amount
    assert_equal '2449215D7MJG4NP36 SQ *BLACKS SLIDERS, SALT LAKE CIT UT', transaction.description
  end

  def test_transaction_extraction_supplies_income
    transaction = BudgetUpdateScript::TransactionExtraction.extract_from(INCOME_TRANSACTION).first
    assert_equal 'Income', transaction.category
    assert_equal 100.0, transaction.amount
  end

  def test_transactions_sorts_by_date
    transactions = BudgetUpdateScript::TransactionExtraction.extract_from(TWO_TRANSACTIONS)
    assert transactions.first.date < transactions.last.date
  end

  def test_transactions_output_formatted_csv
    transaction_csv = BudgetUpdateScript.convert(TWO_TRANSACTIONS)
    assert_equal END_RESULT.chomp, transaction_csv
  end
end
