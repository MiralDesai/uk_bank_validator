# frozen_string_literal: true

module UkBankValidator
  # The outcome of validating a sort code and account number pair.
  Result = Data.define(:sort_code, :account_number, :errors) do
    def initialize(sort_code:, account_number:, errors:)
      super(
        sort_code: sort_code&.freeze,
        account_number: account_number&.freeze,
        errors: errors.freeze
      )
    end

    def valid?
      errors.empty?
    end
  end
end
