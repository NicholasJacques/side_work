require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { create(:user)}
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Confirm your account with Sidework")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@sidework.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to have_link('Activate')
    end
  end

end
