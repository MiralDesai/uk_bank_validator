# frozen_string_literal: true

RSpec.describe UkBankValidator::Result do
  subject(:result) { described_class.new(sort_code: +"123456", account_number: +"00123456", errors: []) }

  it { is_expected.to be_valid }
  it { is_expected.to be_frozen }
  it { expect(result.sort_code).to be_frozen }
  it { expect(result.account_number).to be_frozen }
  it { expect(result.errors).to be_frozen }

  context "when a field is invalid" do
    subject(:result) { described_class.new(sort_code: nil, account_number: "00123456", errors: [error]) }

    let(:error) do
      UkBankValidator::Error.new(key: :sort_code_blank, field: :sort_code, message: "Sort code can't be blank.")
    end

    it { is_expected.not_to be_valid }
    it { expect(result.sort_code).to be_nil }
    it { expect(result.errors).to eq([error]) }
  end
end
