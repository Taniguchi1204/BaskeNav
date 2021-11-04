class ApplicationRecord < ActiveRecord::Base
  # applicationRecordのテーブルが
  self.abstract_class = true
end
