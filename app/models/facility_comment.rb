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
      (comments.where(rate: 5).count / comments.all.count.to_f * 100).to_i
    when 4
      (comments.where(rate: 4).count / comments.all.count.to_f * 100).to_i
    when 3
      (comments.where(rate: 3).count / comments.all.count.to_f * 100).to_i
    when 2
      (comments.where(rate: 2).count / comments.all.count.to_f * 100).to_i
    when 1
      (comments.where(rate: 1).count / comments.all.count.to_f * 100).to_i
    end
  end
end
