# frozen_string_literal: true

class AreaInfoService
  def self.populate(row)
    department = Department.find_or_create_by!(name: row[:area])
    position = department.positions.find_or_create_by!(name: row[:cargo])
    function = position.functions.find_or_create_by!(name: row[:funcao])
    { department: department.id, position: position.id, function: function.id }
  end
end
