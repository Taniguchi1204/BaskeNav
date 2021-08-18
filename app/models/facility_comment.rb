class FacilityComment < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :facility_id
    validates :comment
    validates :rate
  end

  belongs_to :user
  belongs_to :facility

  # 評価グラフに反映されるデータ
  def self.rate_persent(number, comments)
    case number
    when 5
      (comments.where("rate like ?", 5.to_f).count / comments.all.count.to_f * 100).to_i
    when 4
      (comments.where("rate like ?", 4.to_f).count / comments.all.count.to_f * 100).to_i
    when 3
      (comments.where("rate like ?", 3.to_f).count / comments.all.count.to_f * 100).to_i
    when 2
      (comments.where("rate like ?", 2.to_f).count / comments.all.count.to_f * 100).to_i
    when 1
      (comments.where("rate like ?", 1.to_f).count / comments.all.count.to_f * 100).to_i
    end
  end
end
