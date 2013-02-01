# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log_item do
    log nil
    user nil
    position 1
    content "MyString"
    milestone false
    complete false
  end
end
