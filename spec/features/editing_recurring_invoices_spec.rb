require 'rails_helper'

feature "Editing Recurring Invoices" do
  before  do
    recurring_invoice = FactoryGirl.create(:recurring_invoice)
    visit "/recurring_invoices/#{recurring_invoice.id}/edit"
  end

  scenario "Updating a recurring invoice", :js => true, driver: :webkit do
    fill_in "Name", with: "TextMate 2 beta"
    click_on "Save"
    expect(page).to have_content("Recurring Invoice was successfully updated.")
  end

  scenario "Updating a recurring invoice with invalid attributes is bad", :js => true, driver: :webkit do
    fill_in "Name", with: ""
    fill_in "Starting date", with: Date.current
    fill_in "Finishing date", with: Date.yesterday
    click_on "Save"
    expect(page).to have_content("Customer name or identification is required.")
    expect(page).to have_content("The end date must be greater than the start date.")
  end
end
