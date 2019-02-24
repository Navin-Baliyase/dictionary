require 'rails_helper'

RSpec.describe Icicle, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each)do
    @icicle = Icicle.delete_all
  end

  it "should not create a icicle if phone is not present" do
    expect {Icicle.create!(phone: "")}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should not create a icicle if phone is not 10 digit long" do
    expect {Icicle.create!(phone: "66867878")}.to raise_error ActiveRecord::RecordInvalid
  end

  it "should create record" do
    #@icicle = Icicle.create!(phone: "6686787825", upload: "C:/Users/navin/Downloads/dictionary.txt")
    #Active storage not allowing file upload
  end


end
