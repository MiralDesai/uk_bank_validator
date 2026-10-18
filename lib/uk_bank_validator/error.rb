# frozen_string_literal: true

module UkBankValidator
  # A single validation failure.
  Error = Data.define(:key, :field, :message) do
    def initialize(key:, field:, message:)
      super(key: key, field: field, message: message.freeze)
    end
  end
end
