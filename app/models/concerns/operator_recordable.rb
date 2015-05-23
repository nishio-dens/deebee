module OperatorRecordable
  extend ActiveSupport::Concern

  included do
    before_create do
      operator = User.current
      self.creator_name = self.updater_name = operator.username
      self.created_by = self.updated_by = operator.id
    end

    before_update do
      operator = User.current
      self.updater_name = operator.username
      self.updated_by = operator.id
    end
  end

  module ClassMethods
  end
end
