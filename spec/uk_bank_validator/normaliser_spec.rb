# frozen_string_literal: true

RSpec.describe UkBankValidator::Normaliser do
  describe "#sort_code" do
    it "strips spaces and hyphens" do
      ["12-34-56", "12 34 56", "123456", "  12  -  34  -  56  "].each do |input|
        expect(described_class.sort_code(input)).to eq(["123456", nil])
      end
    end

    it "rejects blank input" do
      ["", "   ", "---"].each do |input|
        expect(described_class.sort_code(input)).to eq([nil, :sort_code_blank])
      end
    end

    it "rejects non-numeric input" do
      ["12A456", "12.34.56", "１２３４５６", "12\u00A03456"].each do |input|
        expect(described_class.sort_code(input)).to eq([nil, :sort_code_non_numeric])
      end
    end

    it "rejects wrong lengths" do
      ["12345", "1234567", "1" * 65].each do |input|
        expect(described_class.sort_code(input)).to eq([nil, :sort_code_length])
      end
    end

    it "rejects invalid encoding" do
      input = "\xFF".b.force_encoding(Encoding::UTF_8)
      expect(described_class.sort_code(input)).to eq([nil, :sort_code_non_numeric])
    end
  end

  describe "#account_number" do
    it "strips spaces and pads to 8 digits" do
      { "123456" => "00123456", "1234567" => "01234567", "12345678" => "12345678" }.each do |input, expected|
        expect(described_class.account_number(input)).to eq([expected, nil])
      end
    end

    it("strips loose spacing") { expect(described_class.account_number(" 0 0 1 2 3 4 5 6 ")).to eq(["00123456", nil]) }

    it "rejects blank and non-numeric input" do
      {
        "" => :account_number_blank, "   " => :account_number_blank,
        "12A456" => :account_number_non_numeric, "12-34-56" => :account_number_non_numeric,
        "１２３４５６" => :account_number_non_numeric, "12\u00A03456" => :account_number_non_numeric
      }.each do |input, error|
        expect(described_class.account_number(input)).to eq([nil, error])
      end
    end

    it "rejects wrong lengths" do
      ["12345", "123456789", "1" * 65].each do |input|
        expect(described_class.account_number(input)).to eq([nil, :account_number_length])
      end
    end

    it "rejects invalid encoding" do
      input = "\xFF".b.force_encoding(Encoding::UTF_8)
      expect(described_class.account_number(input)).to eq([nil, :account_number_non_numeric])
    end
  end
end
