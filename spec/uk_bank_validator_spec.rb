# frozen_string_literal: true

RSpec.describe UkBankValidator do
  it "has a semantic version number" do
    expect(UkBankValidator::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end
end
