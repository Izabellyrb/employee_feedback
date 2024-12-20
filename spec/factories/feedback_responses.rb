# frozen_string_literal: true

FactoryBot.define do
  factory :feedback_response do
    name { "Demo 001" }
    email { "demo001@teste.com.br" }
    corporate_email { "demo001@teste.com.br" }
    location { "brasília" }
    company_tenure { "entre 1 e 2 anos" }
    gender { "masculino" }
    generation { "geração z" }
    company_level_0 { "empresa" }
    directorate_level_1 { "diretoria a" }
    management_level_2 { "gerência a1" }
    coordination_level_3 { "coordenação a11" }
    area_level_4 { "área a112" }
    response_date { "20/01/2022" }
    interest_in_position { 7 }
    comments_interest_in_position { nil }
    contribution { 1 }
    comments_contribution { nil }
    learning_and_development { 1 }
    comments_learning_and_development { nil }
    feedback { 6 }
    comments_feedback { nil }
    interaction_with_manager { 6 }
    comments_interaction_with_manager { nil }
    clarity_about_career_opportunities { 6 }
    comments_clarity_about_career_opportunities { "Meu gestor é acessível e apoia minha carreira." }
    expectation_of_permanence { 2 }
    comments_expectation_of_permanence { nil }
    employee_net_promoter_score { 5 }
    open_comments_enps { "A empresa tem um excelente ambiente de trabalho e equipe colaborativa." }
    department
    position
    function
  end
end
