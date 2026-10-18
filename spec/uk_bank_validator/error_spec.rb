# frozen_string_literal: true

RSpec.describe UkBankValidator::Error do
  subject(:error) do
    described_class.new(
      key: :sort_code_blank,
      field: :sort_code,
      message: +"Sort code can't be blank."
    )
  end

  it "exposes the error details" do
    expect(error.key).to eq(:sort_code_blank)
    expect(error.field).to eq(:sort_code)
    expect(error.message).to eq("Sort code can't be blank.")
  end

  it "is frozen" do
    expect(error).to be_frozen
    expect(error.message).to be_frozen
  end
end
