# frozen_string_literal: true

require "csv"

class ImportService
  def initialize(dataset_file)
    @csv_file = dataset_file
  end

  def run
    ActiveRecord::Base.transaction do
      CSV.foreach(@csv_file, headers: true, header_converters: :symbol, col_sep: ";") do |row|
        validate_rows(row)

        area_info = AreaInfoService.populate(row)
        FeedbackResponse.find_or_create_by!(feedback_attributes(row, area_info))
      end

      { message: I18n.t("activerecord.messages.processed"), status: :ok }
    end
  rescue ArgumentError => e
    { message: I18n.t("activerecord.messages.not_processed", error: e.message), status: :unprocessable_entity }
  rescue StandardError => e
    { message: I18n.t("activerecord.messages.not_processed", error: e.message), status: :internal_server_error }
  end

  private

  def validate_rows(row)
    required_fields = %i[nome email email_corporativo area cargo funcao localidade
                         tempo_de_empresa genero geracao n0_empresa n1_diretoria n2_gerencia
                         n3_coordenacao n4_area data_da_resposta interesse_no_cargo contribuio
                         aprendizado_e_desenvolvimento interao_com_gestor clareza_sobre_possibilidades_de_carreira
                         feedback expectativa_de_permanncia enps
                        ]

    missing_fields = required_fields.select { |field| row[field].blank? }

    return unless missing_fields.any?

    raise ArgumentError, I18n.t("activerecord.messages.blank", fields: missing_fields.join(", "))
  end

  def feedback_attributes(row, area_info)
    {
      name: row[:nome],
      email: row[:email],
      corporate_email: row[:email_corporativo],
      department_id: area_info[:department],
      position_id: area_info[:position],
      function_id: area_info[:function],
      location: row[:localidade],
      company_tenure: row[:tempo_de_empresa],
      gender: row[:genero],
      generation: row[:geracao],
      company_level_0: row[:n0_empresa],
      directorate_level_1: row[:n1_diretoria],
      management_level_2: row[:n2_gerencia],
      coordination_level_3: row[:n3_coordenacao],
      area_level_4: row[:n4_area],
      response_date: row[:data_da_resposta],
      interest_in_position: row[:interesse_no_cargo],
      comments_interest_in_position: row[:comentrios_interesse_no_cargo],
      contribution: row[:contribuio],
      comments_contribution: row[:comentrios_contribuio],
      learning_and_development: row[:aprendizado_e_desenvolvimento],
      comments_learning_and_development: row[:comentrios_aprendizado_e_desenvolvimento],
      feedback: row[:feedback],
      comments_feedback: row[:comentrios_feedback],
      interaction_with_manager: row[:interao_com_gestor],
      comments_interaction_with_manager: row[:comentrios_interao_com_gestor],
      clarity_about_career_opportunities: row[:clareza_sobre_possibilidades_de_carreira],
      comments_clarity_about_career_opportunities: row[:comentrios_clareza_sobre_possibilidades_de_carreira],
      expectation_of_permanence: row[:expectativa_de_permanncia],
      comments_expectation_of_permanence: row[:comentrios_expectativa_de_permanncia],
      employee_net_promoter_score: row[:enps],
      open_comments_enps: row[:aberta_enps]
    }
  end
end
