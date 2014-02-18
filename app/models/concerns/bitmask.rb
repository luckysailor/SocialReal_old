module Bitmask
	extend ActiveSupport::Concern

  included do
    validate do
      return unless self.roles_mask_changed?
      errors.add(:roles_mask, :invalid) unless check_bitmask(self.roles_mask)
    end
  end

  def check_bitmask(bitmask)
    @@bitmask_valid = _set_bitmask(bitmask)
    @@bitmask_valid.present? ? @@bitmask_valid : nil
  end

  private
    def _set_bitmask(bitmask)
      return unless _valid_bitmask?(bitmask)
      
      unless self.new_record?
        if self.roles_mask_was == bitmask
            self.errors.add(:roles_mask, 'User have the same bitmask.')
            return
        end
      end
      
      bitmask
  	end

  	def _valid_bitmask?(bitmask)
  		bitmasks = [1, 2, 4, 8, 16, 32]
  		bitmasks.include?(bitmask) ? bitmask : nil
  	end
end