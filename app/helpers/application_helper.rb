# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for_flash type
    FLASH_TYPES[type] || type
  end
end
