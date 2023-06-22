FactoryBot.define do
  factory :comment do
    detail { "Here is a comment!" }
    association :project, factory: :project
  end
end
