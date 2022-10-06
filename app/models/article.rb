class Article < ApplicationRecord
    validates :title, presence: true, length: {minimum: 6, maximum: 100} # Dont allow to save withou data according to the parameter Ex: :title
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
    #article.errors.full_messages to see in rails console
    belongs_to :user
end