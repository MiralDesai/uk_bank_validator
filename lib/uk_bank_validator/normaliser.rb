# frozen_string_literal: true

module UkBankValidator
  # Applies the 0.1 format rules to a single field.
  #
  # Each method returns [normalised_value, error_key]. Exactly one element is
  # nil: the value when valid, or the error key when invalid.
  module Normaliser
    module_function

    def sort_code(value)
      return [nil, :sort_code_non_numeric] unless value.valid_encoding?

      normalised = value.delete(" -")
      return [nil, :sort_code_blank] if normalised.empty?
      return [nil, :sort_code_non_numeric] unless digits?(normalised)
      return [nil, :sort_code_length] unless normalised.length == 6

      [normalised, nil]
    end

    def account_number(value)
      return [nil, :account_number_non_numeric] unless value.valid_encoding?

      normalised = value.delete(" ")
      return [nil, :account_number_blank] if normalised.empty?
      return [nil, :account_number_non_numeric] unless digits?(normalised)
      return [nil, :account_number_length] unless normalised.length.between?(6, 8)

      [normalised.rjust(8, "0"), nil]
    end

    def digits?(value)
      value.match?(/\A[0-9]+\z/)
    end
    private_class_method :digits?
  end
end
