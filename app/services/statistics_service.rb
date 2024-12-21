# frozen_string_literal: true

class StatisticsService
  def self.structure_stats
    {
      areas: FeedbackResponse.joins(:department).group("departments.name").count,
      cargos: FeedbackResponse.joins(:position).group("positions.name").count,
      funcoes: FeedbackResponse.joins(:function).group("functions.name").count
    }
  end

  def self.location_stats
    FeedbackResponse.group(:location).count
  end
end
