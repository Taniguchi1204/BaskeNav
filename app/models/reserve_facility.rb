# 予約時間が重複することを防ぐ
class ReserveFacilityValidator < ActiveModel::EachValidator
  
  # 予約が重複していないか確認し、重複している場合はエラーメッセージを表示させる
  def validate_each(record, attribute, value)
    new_start = record.start
    new_end   = record.finish

    return unless new_start.present? && new_end.present?

    if record.id.present?
      not_own_periods = ReserveFacility.where('id NOT IN (?) AND start <= ? AND finish >= ?', record.id, new_end, new_start)
    else
      not_own_periods = ReserveFacility.where('start <= ? AND finish >= ?', new_end, new_start)
    end

    record.errors.add(attribute, 'はすでに予約されています。') if not_own_periods.present?
  end
end


class ReserveFacility < ApplicationRecord
  with_options presence: true do
    validates :facility_id
    validates :user_id
    validates :number
    validates :start
    validates :finish
  end

  validates :start, reserve_facility: true
  validates :finish, reserve_facility: true
  validate  :start_end_check


  belongs_to :user
  belongs_to :facility

  # 予約日付の逆転防止
  def start_end_check
    if self.start.present? && self.finish.present?
      errors.add(:finish, "は開始時刻より前の時間は登録できません。") unless
      self.start < self.finish
    end
  end
end
