# == Schema Information
#
# Table name: translation_histories
#
#  id             :integer          not null, primary key
#  translation_id :integer          not null
#  variable_name  :string(255)      not null
#  ja             :text(65535)      not null
#  en             :text(65535)      not null
#  project_id     :integer          not null
#  creator_name   :string(255)      not null
#  updater_name   :string(255)      not null
#  changer_name   :string(255)      not null
#  created_by     :integer          not null
#  updated_by     :integer          not null
#  changed_by     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  changed_at     :integer          not null
#  deleted_at     :datetime
#

class TranslationHistory < ActiveRecord::Base
end
